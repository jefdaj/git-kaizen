{-# LANGUAGE ScopedTypeVariables #-}

module Run where

import Config
import GitKaizen.Types

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

runListOutputs = undefined

runMainScript = undefined

setupTmpdir = undefined

teardownTmpdir = undefined

withCustomTmpdir = undefined

-- log to kaizen.log in the tmpdir, only mention when there's a problem
loggingFn = undefined

runNextSteps = undefined
