module Untar2 (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kName = "untar2"
  , kInPatterns = [GlobOne "*.tar*"]
  , kOutPaths = outpaths
  , kGuard = guard
  , kCommand = undefined -- TODO write this
  }

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
outpaths :: [String] -> [String]
outpaths inpaths = [dropExtension $ head inpaths]

-- TODO use asserts and return () rather than returning a bool?
guard :: [String] -> [String] -> IO Bool
guard inpaths outpaths = return $
  (length inpaths  == 1) && (length outpaths == 1)
