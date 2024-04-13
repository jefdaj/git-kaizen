module GatherTarballs (kaizen) where

import GitKaizen.Interface
import System.FilePath.Posix (dropExtension)

kaizen :: Kaizen
kaizen = Kaizen
  { kzName = "gather tarballs"
  , kzInPatterns = [GlobOne "*.tar*"]
  , kzOutPaths = outpaths
  , kzDescribe = desc
  , kzGuard = guard
  , kzCommand = undefined -- TODO write this
  }

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
outpaths :: [String] -> [String]
outpaths inpaths = [dropExtension $ head inpaths]

-- TODO relativize paths?
desc :: [String] -> [String] -> String
desc inpaths outpaths = unwords
  [ "extract from"
  , "'" ++ head inpaths ++ "'"
  , "->"
  , "'" ++ head outpaths ++ "'"
  ]

-- TODO use asserts and return () rather than returning a bool?
guard :: [String] -> [String] -> IO Bool
guard inpaths outpaths = return $
  (length inpaths  == 1) && (length outpaths == 1)
