module GatherGitRepos (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kDesc = "gather git repos"
  , kListInputs = \_ -> return []
  , kListOutputs = \_ -> return []
  , kMainScript = \_ _ -> return () -- TODO write this
  }

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
-- TODO should it be an error for this to return empty?
-- outpaths :: [String] -> [String]
-- outpaths inpaths = ["repos" </> (takeBaseName $ head inpaths)]
