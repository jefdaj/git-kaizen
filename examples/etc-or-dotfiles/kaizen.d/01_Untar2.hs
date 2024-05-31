module Untar2 (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kDesc = "untar2"
  , kListInputs = undefined -- [GlobOne "*.tar*"]
  , kListOutputs = outpaths
  , kMainScript = undefined -- TODO write this
  }

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
outpaths :: [String] -> [String]
outpaths inpaths = [dropExtension $ head inpaths]
