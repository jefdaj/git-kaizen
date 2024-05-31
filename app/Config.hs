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

defaultKaizenDir :: FilePath -> FilePath
defaultKaizenDir repoDir = repoDir </> ".kaizen"

defaultConfig :: IO Config
defaultConfig = do
  repo <- getCurrentDirectory
  tmp  <- getTemporaryDirectory
  let cfg = Config
        { repoDir   = repo
        , tmpDir    = tmp
        , kaizenDir = defaultKaizenDir repo
        , verbose   = True
        }
  return cfg

-- | Apply overrides from Docopt
overrideConfig :: Arguments -> Config -> Config
overrideConfig args defaults =
  let long s = getArg    args $ longOption s
      bool s = isPresent args $ longOption s
      rDir = fromMaybe (repoDir defaults) $ long "repodir"
  in defaults
       -- TODO convert everything to absolute paths here?
       { repoDir   = rDir
       , tmpDir    = fromMaybe (tmpDir defaults) $ long "tmpdir"
       , kaizenDir = fromMaybe (defaultKaizenDir rDir) $ long "kaizendir"
       , verbose   = bool "verbose" -- TODO any point having a default?
       }
