module Untar2 (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kDesc = "untar2"
  , kListInputs = \_ -> return [] -- [GlobOne "*.tar*"]
  -- , kListOutputs = outpaths
  , kListOutputs = \_ -> return []
  , kMainScript = \_ _ -> return () -- TODO write this
  }

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
outpaths :: [String] -> [String]
outpaths inpaths = [dropExtension $ head inpaths]
