{-# LANGUAGE ScopedTypeVariables #-}

module Load where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck

import GitKaizen.Types (Kaizen(..), Priority(..))

import System.FilePath (takeBaseName)
import Data.List (isInfixOf, isPrefixOf)
import GHC
import GHC.Paths
import Unsafe.Coerce
import System.Directory (getDirectoryContents)
import System.FilePath ((</>))
import System.FilePattern.Directory (FilePattern, getDirectoryFiles)
import Data.List (intercalate)
import Data.List.Split (splitOn)

import Paths_git_kaizen

import Colog.Core (LogAction(..), (<&), logStringStdout)
import Control.Monad.IO.Class (MonadIO)
import Control.Monad (forM_)

-- Code is mainly based on loadPlugins from jgm/gitit
loadKaizen :: LogAction IO String -> FilePath -> IO (Kaizen, Priority)
loadKaizen log kaizenPath = do
  log <& ("loading " ++ kaizenPath)
  runGhc (Just libdir) $ do
    dflags <- getSessionDynFlags
    setSessionDynFlags dflags
    addTarget =<< guessTarget kaizenPath Nothing Nothing
    r <- load LoadAllTargets
    case r of
      Failed -> error $ "Error loading: " ++ kaizenPath
      Succeeded -> return ()
    let (n:xs) = splitOn "_" $ takeBaseName kaizenPath
        priority = Priority $ read n -- TODO maybe version of this
        modName = intercalate "_" xs -- TODO can modules have _ in their names?
    pr <- parseImportDecl "import Prelude"
    i <- parseImportDecl "import GitKaizen.Interface" -- TODO why is this required?
    m <- parseImportDecl ("import " ++ modName)
    setContext [IIDecl m, IIDecl  i, IIDecl pr]
    value <- compileExpr (modName ++ ".kaizen :: Kaizen")
    let value' = (unsafeCoerce value) :: Kaizen
    return (value', priority)

-- TODO is there a plural of kaizen? not sure how Japanese works
loadKaizens :: LogAction IO String -> FilePath -> IO [(Kaizen, Priority)]
loadKaizens log kDir = do
  log <& ("loading from " ++ kDir)
  -- TODO is there a cleaner ls function?
  kPaths <- fmap (map (kDir </>)) $ getDirectoryFiles kDir ["*.hs"]
  ks <- mapM (loadKaizen log) kPaths
  log <& "finished loading"
  return ks

-- | For disabling logs during unit tests.
-- TODO where should this live?
logNowhere :: MonadIO m => LogAction m String
logNowhere = LogAction $ \_ -> return ()

-- | Test loading the backups example.
-- TODO pass a no-logging logger here
unit_loadExamplesBackups :: Assertion
unit_loadExamplesBackups = do
  kDir <- getDataFileName "examples/backups/kaizen.d"
  ((k1,p1):(k2,p2):[]) <- loadKaizens logNowhere kDir
  kDesc k1 @?= "gather tarballs"
  kDesc k2 @?= "gather git repos"
  p1 @?= (Priority 1)
  p2 @?= (Priority 2)

-- | Test loading the etc-or-dotfiles example.
-- TODO pass a no-logging logger here
unit_loadExamplesEtcOrDotfiles :: Assertion
unit_loadExamplesEtcOrDotfiles = do
  kDir <- getDataFileName "examples/etc-or-dotfiles/kaizen.d"
  ((v,p):ks) <- loadKaizens logNowhere kDir
  length ks @?= 0
  kDesc v @?= "untar2"
  p @?= (Priority 1)

unit_load_all_examples :: Assertion
unit_load_all_examples = do
  exRoot <- getDataFileName "examples"
  exDirs <- filter (not . flip elem [".", ".."]) <$> getDirectoryContents exRoot
  let kDirs = map (\p -> exRoot </> p </> "kaizen.d") exDirs
  forM_ kDirs $ loadKaizens logNowhere
