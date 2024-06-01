{-# LANGUAGE ScopedTypeVariables #-}

module Run where

import Config
import GitKaizen.Types
import GitKaizen.Interface
import System.Process -- TODO specifics

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
runListOutputs :: Kaizen -> FilePath -> FilePath -> [FilePath] -> IO [FilePath]
runListOutputs = do
  outPaths <- runMainScriptCC $ addToEnv [("GITKAIZEN_RUN_MODE", "LIST_OUTPUTS")]
  return outPaths

-- TODO to interface
-- type CustomizeCreateProcess = [(String, String)] -> CreateProcess -> CreateProcess

-- TODO proper merge in case the particular env variable exists
addToEnv :: [(String, String)] -> CreateProcess -> CreateProcess
addToEnv myEnv c = case env c of
  Nothing -> c { env = Just myEnv }
  Just vs -> c { env = Just $ vs ++ myEnv }

runMainScript :: Kaizen -> FilePath -> FilePath -> [FilePath] -> IO [FilePath]
runMainScript = runMainScriptCC id

-- TODO should this have the whole config?
runMainScriptCC :: (CreateProcess -> CreateProcess) -> Kaizen -> FilePath -> FilePath -> [FilePath] -> IO [FilePath]
runMainScriptCC cc kz repoDir binDir inPaths = do
  let bin = binDir </> kMainScript kz
  out <- runInRepoCC cc repoDir bin inPaths
  return $ lines out

setupTmpdir = undefined

teardownTmpdir = undefined

withCustomTmpdir = undefined

-- log to kaizen.log in the tmpdir, only mention when there's a problem
loggingFn = undefined

runNextSteps = undefined
