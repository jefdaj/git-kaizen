module Config
  ( Config(..)
  , defaultConfig
  , overrideConfig
  )
  where

import System.FilePath ((</>))
import System.Directory (getCurrentDirectory, getTemporaryDirectory)
import Data.Maybe (fromMaybe)
import System.Console.Docopt -- TODO specifics

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
overrideConfig :: Arguments -> Config -> Config
overrideConfig args defaults =
  let long s = getArg    args $ longOption s
      bool s = isPresent args $ longOption s
  in defaults
       { repoDir   = fromMaybe (repoDir   defaults) $ long "repodir"
       , tmpDir    = fromMaybe (tmpDir    defaults) $ long "tmpdir"
       , kaizenDir = fromMaybe (kaizenDir defaults) $ long "kaizendir"
       , verbose   = bool "verbose" -- TODO any point having a default?
       }
