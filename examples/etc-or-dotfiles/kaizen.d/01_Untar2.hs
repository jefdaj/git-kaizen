module Untar2 (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kDescription = "untar2"
  , kListInputs  = \_ -> return [] -- [GlobOne "*.tar*"]
  -- , kListOutputs = \_ -> return []
  , kMainScript  = "untar2.sh"
  }

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
-- outpaths :: [String] -> [String]
-- outpaths inpaths = [dropExtension $ head inpaths]
