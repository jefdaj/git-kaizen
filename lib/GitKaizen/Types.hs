module GitKaizen.Types where

import Data.Default
import System.FilePattern (FilePattern)

-- TODO regexes, maybe with capture groups
-- TODO exact literal matches?
-- TODO eval bash commands?
-- TODO haskell predicates on filepaths
-- TODO haskell predicates on sets of filepaths? (may not be feasible)
-- TODO haskell predicates on dir tree nodes (would work for git dirs!)
-- TODO output of IO functions?
-- TODO rename: InputFilesSearch?
--data InPattern
--     = GlobOne String -- ^ Glob and invoke kaizen once per match
--     | GlobAll String -- ^ Glob and invoke kaizen once with a list of matches
--     deriving (Read, Show, Eq)

-- TODO generalize to kListOutputs "results" and have fields like "added" and
--      "removed"?  then this could be called preview

-- | Top level commment example
data Kaizen = Kaizen
    { kDesc        :: String
    , kListInputs  :: Maybe FilePath -> IO [FilePath]
    , kListOutputs :: [String] -> [String]
    , kMainScript  :: [String] -> [String] -> IO ()

    -- TODO was this helpful? kDescribe   :: [String] -> [String] -> String
    -- TODO was this helpful? kGuard      :: [String] -> [String] -> IO Bool
    -- TODO actual command.. shelly? turtle? system thing?
    }

-- | Experiment with determining kaizen priority via filename, Unix style
newtype Priority = Priority Int
  deriving (Show, Eq)
