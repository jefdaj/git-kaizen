module GitKaizen.Plugins where

import GitKaizen.Types (Plugin, Priority(..))

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

-- Plugin code is mainly based on jgm/gitit
loadPlugin :: FilePath -> IO (Plugin, Priority)
loadPlugin pluginPath = do
  -- logM "gitit" WARNING ("Loading plugin '" ++ pluginName ++ "'...")
  runGhc (Just libdir) $ do
    dflags <- getSessionDynFlags
    setSessionDynFlags dflags
    -- initDynFlags
    -- unless ("Network.Gitit.Plugin." `isPrefixOf` pluginName)
    -- $ do
    addTarget =<< guessTarget pluginPath Nothing Nothing
    r <- load LoadAllTargets
    case r of
      Failed -> error $ "Error loading plugin: " ++ pluginPath
      Succeeded -> return ()
    -- let modName =
    --       if "Network.Gitit.Plugin" `isPrefixOf` pluginName
    --          then pluginName
    --          else if "Network/Gitit/Plugin/" `isInfixOf` pluginName
    --                  then "Network.Gitit.Plugin." ++ takeBaseName pluginName
    --                  else takeBaseName pluginName
    let (n:xs) = splitOn "_" $ takeBaseName pluginPath
        priority = Priority $ read n -- TODO maybe version of this
        base = intercalate "_" xs -- TODO can modules have _ in their names?
        modName = "GitKaizen.Plugins." ++ base
    pr <- parseImportDecl "import Prelude"
    i <- parseImportDecl "import GitKaizen.PluginInterface" -- TODO why is this required?
    m <- parseImportDecl ("import " ++ modName)
    setContext [IIDecl m, IIDecl  i, IIDecl pr]
    value <- compileExpr (modName ++ ".plugin :: Plugin")
    let value' = (unsafeCoerce value) :: Plugin
    return (value', priority)

loadPlugins :: FilePath -> IO [(Plugin, Priority)]
loadPlugins pluginDir = do
  pluginPaths <- fmap (map (pluginDir </>)) $ getDirectoryFiles pluginDir ["*.hs"]
  plugins' <- mapM loadPlugin pluginPaths
  -- unless (null pluginNames) $ logM "gitit" WARNING "Finished loading plugins."
  return plugins'

-- plugins :: [Plugin]
-- plugins = undefined
