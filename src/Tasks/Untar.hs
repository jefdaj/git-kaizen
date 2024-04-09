module Tasks.Untar where

import Lib.Types
import System.FilePath.Posix (dropExtension)

task = Task
  { taskName = "untar"

-- TODO constructors for different pattern types rather than String here
  , taskInPatterns =
      [ GlobOne "*.tar*"
      ]

  -- TODO generalize to "results" and have fields like "added" and "removed"?
  , taskOutPaths = \inpaths ->
      [dropExtension $ head inpaths]

  , taskDescribe = \inpaths outpaths ->
      let inpath  = "'" ++ head inpaths  ++ "'"
          outpath = "'" ++ head outpaths ++ "'"
      in unwords ["untar", inpath, "->", outpath]

  -- TODO use asserts and return () rather than returning a bool?
  , taskGuard = \inpaths outpaths -> return $
      (length inpaths  == 1) && (length outpaths == 1)
  }
