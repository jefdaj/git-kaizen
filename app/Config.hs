module Config
  ( Config(..)
  , defaultConfig
  , overrideConfig
  )
  where

import System.FilePath ((</>), isRelative)
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

-- TODO better absolute paths based on the one in bigtrees?
makeAbsolute :: FilePath -> FilePath -> FilePath
makeAbsolute cwd p = if isRelative p then cwd </> p else p

-- | Apply overrides from Docopt
overrideConfig :: Arguments -> Config -> IO Config
overrideConfig args defaults = do
  cwd <- getCurrentDirectory

  let long s = getArg    args $ longOption s
      bool s = isPresent args $ longOption s

      rDir = fromMaybe (repoDir defaults) $ long "repodir"
      tDir = fromMaybe (tmpDir defaults) $ long "tmpdir"
      kDir = fromMaybe (defaultKaizenDir rDir) $ long "kaizendir"
      v    = bool "verbose" -- TODO any point in a default for this?

  return $ defaults
       { repoDir   = makeAbsolute cwd rDir
       , tmpDir    = makeAbsolute cwd tDir
       , kaizenDir = makeAbsolute cwd kDir
       , verbose   = v
       }
