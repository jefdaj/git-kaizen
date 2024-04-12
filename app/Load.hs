module Load where

import GitKaizen.Types (Kaizen, Priority(..))

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
