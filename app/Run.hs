{-# LANGUAGE ScopedTypeVariables #-}

module Run where

import Config
import GitKaizen.Types
import GitKaizen.Interface
import System.Process -- TODO specifics
import System.FilePath (makeRelative)

-- import Test.Tasty
-- import Test.Tasty.HUnit
-- import Test.Tasty.QuickCheck

-- import GitKaizen.Types (Kaizen(..), Priority(..))

-- import System.FilePath (takeBaseName)
-- import Data.List (isInfixOf, isPrefixOf)
-- import GHC
-- import GHC.Paths
-- import Unsafe.Coerce
-- import System.Directory (getDirectoryContents)
-- import System.FilePath ((</>))
-- import System.FilePattern.Directory (FilePattern, getDirectoryFiles)
-- import Data.List (intercalate)
-- import Data.List.Split (splitOn)

-- import Paths_git_kaizen

-- import Colog.Core (LogAction(..), (<&), logStringStdout)
-- import Control.Monad.IO.Class (MonadIO)
-- import Control.Monad (forM_)

runListInputs :: Config -> Kaizen -> IO [[FilePath]]
runListInputs cfg kz = (kListInputs kz) (repoDir cfg) []

-- TODO better syntax for this? make the shell script usage simple
-- TODO better design for passing myEnv around
runListOutputs :: [(String, String)] -> FilePath -> Kaizen -> FilePath -> [FilePath] -> IO [FilePath]
runListOutputs myEnv repoDir kz binDir inPaths = do
  outPaths <- runMainScriptCC
                (addToEnv $ [("GITKAIZEN_RUN_MODE", "LIST_OUTPUTS")] ++ myEnv)
                repoDir kz binDir inPaths
  let relPaths = map (makeRelative repoDir) outPaths
  return relPaths

-- TODO to interface
-- type CustomizeCreateProcess = [(String, String)] -> CreateProcess -> CreateProcess

-- TODO proper merge in case the particular env variable exists
addToEnv :: [(String, String)] -> CreateProcess -> CreateProcess
addToEnv myEnv c = case env c of
  Nothing -> c { env = Just myEnv }
  Just vs -> c { env = Just $ vs ++ myEnv }

runMainScript :: FilePath -> Kaizen -> FilePath -> [FilePath] -> IO [FilePath]
runMainScript = runMainScriptCC id

-- TODO should this have the whole config?
runMainScriptCC
  :: (CreateProcess -> CreateProcess)
  -> FilePath -> Kaizen -> FilePath -> [FilePath]
  -> IO [FilePath]
runMainScriptCC cc repoDir kz binDir inPaths = do
  let cmd = binDir </> kMainScript kz
  out <- runInRepoCC cc repoDir cmd inPaths
  return $ lines out

setupTmpdir = undefined

teardownTmpdir = undefined

withCustomTmpdir = undefined

-- log to kaizen.log in the tmpdir, only mention when there's a problem
loggingFn = undefined

runNextSteps = undefined
