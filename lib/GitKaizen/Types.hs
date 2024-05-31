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

-- Take an optional FilePath supplied by the user for where to search,
-- and return a list of input lists, where each list is one main script call.
-- TODO should the path always exist and default to git-kaizen supplying the root?
type ListInputsFn  = Maybe FilePath -> IO [[FilePath]]

-- Given the inputs to one main script call, return the outputs.
-- TODO replace with the script run with a flag or var to print outputs
-- TODO later, add an option that says whether the script will be able to predict its outputs before the inputs exist or not. If so, it can be chained.
-- type ListOutputsFn = [FilePath] -> IO [FilePath]

-- Take the inputs and actually run the script, hopefully producing the
-- expected outputs.
-- TODO git-kaizen should probably enforce that, right?
-- type MainScriptFn  = [FilePath] -> IO () -- TODO return anything? exit code?

-- | Top level commment example
data Kaizen = Kaizen
    { kDescription :: String
    , kListInputs  :: ListInputsFn
    -- , kListOutputs :: ListOutputsFn
    , kMainScript  :: FilePath

    -- TODO was this helpful? kDescriptionribe   :: [String] -> [String] -> String
    -- TODO was this helpful? kGuard      :: [String] -> [String] -> IO Bool
    -- TODO actual command.. shelly? turtle? system thing?
    }

-- | If I decide to add any other "script" types (haskell fns?),
-- they'll go here.
-- data Script = Script FilePath
--   deriving (Read, Show, Eq)

-- | Experiment with determining kaizen priority via filename, Unix style
newtype Priority = Priority Int
  deriving (Show, Eq)
