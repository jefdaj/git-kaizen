module GitKaizen.Types where

import System.FilePattern (FilePattern)

-- TODO regexes, maybe with capture groups
-- TODO exact literal matches?
-- TODO eval bash commands?
-- TODO haskell predicates on filepaths
-- TODO haskell predicates on sets of filepaths? (may not be feasible)
-- TODO haskell predicates on dir tree nodes (would work for git dirs!)
-- TODO output of IO functions?
-- TODO rename: InputFilesSearch?
data InPattern
    = GlobOne String -- ^ Glob and invoke kaizen once per match
    | GlobAll String -- ^ Glob and invoke kaizen once with a list of matches
    deriving (Read, Show, Eq)

-- TODO would separate options for anchor + content matching handle everything?
-- TODO mindepth, maxdepth? would fit well with RAM-limited bigtrees later
-- TODO ignore patterns, or negative matches, if they aren't part of filepattern already
data InPattern2 = InPattern2
    { ip2Above   :: Maybe FilePattern -- ^ Search the path above (to) this node from root
    , ip2Below   :: Maybe FilePattern -- ^ Treating this node as root, search the child paths below
    , ip2Recurse :: Bool -- ^ After finding a matching dir, should we also search inside it?
    }
    deriving (Read, Show, Eq)

-- | Top level commment example
data Kaizen = Kaizen
    { kzName       :: String
    , kzInPatterns :: [InPattern]
    , kzOutPaths   :: [String] -> [String]
    , kzDescribe   :: [String] -> [String] -> String
    , kzGuard      :: [String] -> [String] -> IO Bool
    -- TODO actual command.. shelly? turtle? system thing?
    , kzCommand    :: [String] -> [String] -> IO ()
    }

-- | Experiment with determining kaizen priority via filename, Unix style
newtype Priority = Priority Int
  deriving (Show, Eq)
