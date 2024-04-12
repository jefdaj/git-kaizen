module GitKaizen.Types where

-- TODO regexes, maybe with capture groups
-- TODO exact literal matches?
-- TODO eval bash commands?
-- TODO haskell predicates on filepaths
-- TODO haskell predicates on sets of filepaths? (may not be feasible)
-- TODO haskell predicates on dir tree nodes (would work for git dirs!)
-- TODO output of IO functions?
data InPattern
    = GlobOne String -- ^ Glob and invoke task once per match
    | GlobAll String -- ^ Glob and invoke task once with a list of matches
    deriving Show

-- | Top level commment example
-- TODO rename back to Task, or something better
data Plugin = Plugin
    { taskName       :: String
    , taskInPatterns :: [InPattern]
    , taskOutPaths   :: [String] -> [String]
    , taskDescribe   :: [String] -> [String] -> String
    , taskGuard      :: [String] -> [String] -> IO Bool
    -- TODO actual command.. shelly? turtle? system thing?
    , taskCommand    :: [String] -> [String] -> IO ()
    }

-- | Experiment with determining plugin priority via filename, Unix style
newtype Priority = Priority Int
  deriving Show
