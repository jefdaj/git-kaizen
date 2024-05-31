module GatherGitRepos (kaizen) where

import GitKaizen.Interface
import System.FilePath.Posix ((</>), takeBaseName)

kaizen :: Kaizen
kaizen = Kaizen
  { kName = "gather git repos"
  , kInPatterns = [] -- TODO make a search strategy for this
  , kOutPaths = outpaths
  , kGuard = guard
  , kCommand = undefined -- TODO write this
  }

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
-- TODO should it be an error for this to return empty?
outpaths :: [String] -> [String]
outpaths inpaths = ["repos" </> (takeBaseName $ head inpaths)]

-- TODO relativize paths?
desc :: [String] -> [String] -> String
desc inpaths outpaths = unwords
  [ "gather git repos from"
  , "'" ++ head inpaths ++ "'"
  , "->"
  , "'" ++ head outpaths ++ "'"
  ]

-- TODO use asserts and return () rather than returning a bool?
guard :: [String] -> [String] -> IO Bool
guard inpaths outpaths = undefined -- TODO write this
