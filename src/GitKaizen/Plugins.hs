module GitKaizen.Plugins where

import GitKaizen.Types (Plugin)

import System.FilePath (takeBaseName)
import Control.Monad (unless)
import Data.List (isInfixOf, isPrefixOf)
import GHC
import GHC.Paths
import Unsafe.Coerce

loadPlugin :: FilePath -> IO Plugin
loadPlugin pluginName = do
  -- logM "gitit" WARNING ("Loading plugin '" ++ pluginName ++ "'...")
  runGhc (Just libdir) $ do
    dflags <- getSessionDynFlags
    setSessionDynFlags dflags
    -- initDynFlags
    unless ("Network.Gitit.Plugin." `isPrefixOf` pluginName)
      $ do
          addTarget =<< guessTarget pluginName Nothing Nothing
          r <- load LoadAllTargets
          case r of
            Failed -> error $ "Error loading plugin: " ++ pluginName
            Succeeded -> return ()
    let modName =
          if "Network.Gitit.Plugin" `isPrefixOf` pluginName
             then pluginName
             else if "Network/Gitit/Plugin/" `isInfixOf` pluginName
                     then "Network.Gitit.Plugin." ++ takeBaseName pluginName
                     else takeBaseName pluginName
    pr <- parseImportDecl "import Prelude"
    -- TODO figure out my equivalent of this
    -- i <- parseImportDecl "import GitKaizen.Interface"
    m <- parseImportDecl ("import " ++ modName)
    -- setContext [IIDecl m, IIDecl  i, IIDecl pr]
    setContext [IIDecl m, IIDecl pr]
    value <- compileExpr (modName ++ ".task :: Plugin")
    let value' = (unsafeCoerce value) :: Plugin
    return value'

loadPlugins :: [FilePath] -> IO [Plugin]
loadPlugins pluginNames = do
  plugins' <- mapM loadPlugin pluginNames
  -- unless (null pluginNames) $ logM "gitit" WARNING "Finished loading plugins."
  return plugins'

-- plugins :: [Plugin]
-- plugins = undefined
