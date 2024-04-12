{-# LANGUAGE ScopedTypeVariables #-}

module Load where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck

import GitKaizen.Types (Kaizen(..), Priority(..))

import System.FilePath (takeBaseName)
import Control.Monad (unless)
import Data.List (isInfixOf, isPrefixOf)
import GHC
import GHC.Paths
import Unsafe.Coerce
import System.FilePath ((</>))
import System.FilePattern.Directory (FilePattern, getDirectoryFiles)
import Data.List (intercalate)
import Data.List.Split (splitOn)

import Paths_git_kaizen

-- Code is mainly based on loadPlugins from jgm/gitit
loadKaizen :: FilePath -> IO (Kaizen, Priority)
loadKaizen kaizenPath = do
  -- logM "gitit" WARNING ("Loading kaizen '" ++ kaizenName ++ "'...")
  runGhc (Just libdir) $ do
    dflags <- getSessionDynFlags
    setSessionDynFlags dflags
    -- initDynFlags
    -- unless ("Network.Gitit.Kaizen." `isPrefixOf` kaizenName)
    -- $ do
    addTarget =<< guessTarget kaizenPath Nothing Nothing
    r <- load LoadAllTargets
    case r of
      Failed -> error $ "Error loading kaizen: " ++ kaizenPath
      Succeeded -> return ()
    -- let modName =
    --       if "Network.Gitit.Kaizen" `isPrefixOf` kaizenName
    --          then kaizenName
    --          else if "Network/Gitit/Kaizen/" `isInfixOf` kaizenName
    --                  then "Network.Gitit.Kaizen." ++ takeBaseName kaizenName
    --                  else takeBaseName kaizenName
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

-- TODO proper plural of kaizen?
loadKaizens :: FilePath -> IO [(Kaizen, Priority)]
loadKaizens kaizenDir = do
  kaizenPaths <- fmap (map (kaizenDir </>)) $ getDirectoryFiles kaizenDir ["*.hs"]
  kaizens' <- mapM loadKaizen kaizenPaths
  -- unless (null kaizenNames) $ logM "gitit" WARNING "Finished loading kaizens."
  return kaizens'

-- | Test loading the backups example.
unit_loadExamplesBackups :: Assertion
unit_loadExamplesBackups = do
  ((v,p):ks) <- loadKaizens =<< getDataFileName "examples/backups/kaizen.d"
  length ks @?= 0
  kzName v @?= "untar"
  p @?= (Priority 3)

-- | Test loading the etc-or-dotfiles example. Fails as there are no files yet.
unit_loadExamplesEtcOrDotfiles :: Assertion
unit_loadExamplesEtcOrDotfiles = do
  ks <- loadKaizens =<< getDataFileName "examples/etc-or-dotfiles/kaizen.d"
  length ks @?= 0
