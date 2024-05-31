module Config
  ( Config(..)
  , defaultConfig
  , overrideConfig
  )
  where

import System.FilePath ((</>))
import System.Directory (getCurrentDirectory, getTemporaryDirectory)
import Data.Maybe (maybe)

{- Parsed command line args
 - TODO add other stuff from usage.txt, or revise that
 -}
-- TODO remove from non-Cmd modules
data Config = Config
  { repoDir   :: FilePath
  , tmpDir    :: FilePath
  , kaizenDir :: FilePath
  , verbose   :: Bool
  }
  deriving (Read, Show)

defaultConfig :: IO Config
defaultConfig = do
  repo <- getCurrentDirectory
  tmp  <- getTemporaryDirectory
  let cfg = Config
        { repoDir   = repo
        , tmpDir    = tmp
        , kaizenDir = repo </> ".kaizen"
        , verbose   = True
        }
  return cfg

-- | Apply overrides from Docopt
overrideConfig = undefined
