module GitKaizen.Types where

-- TODO regexes, maybe with capture groups
-- TODO exact literal matches?
-- TODO eval bash commands?
-- TODO haskell predicates on filepaths
-- TODO haskell predicates on sets of filepaths? (may not be feasible)
-- TODO haskell predicates on dir tree nodes (would work for git dirs!)
-- TODO output of IO functions?
data InPattern
    = GlobOne String -- ^ Glob and invoke kaizen once per match
    | GlobAll String -- ^ Glob and invoke kaizen once with a list of matches
    deriving Show

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
  deriving Show
