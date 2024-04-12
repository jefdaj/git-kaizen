module GitKaizen.Plugins.Untar (plugin) where

import GitKaizen.PluginInterface
import System.FilePath.Posix (dropExtension)

-- TODO call this data type GitKaizen? Kaizen?
plugin :: Plugin
plugin = Plugin
  { taskName = "untar"
  , taskInPatterns = [GlobOne "*.tar*"]
  , taskOutPaths = outpaths
  , taskDescribe = desc
  , taskGuard = guard
  , taskCommand = undefined -- TODO write this
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
