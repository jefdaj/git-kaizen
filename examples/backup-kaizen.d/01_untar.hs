module FileKaizen.Untar where

import System.FilePath.Posix (dropExtension)

name :: String
name = "untar"

-- TODO constructors for different pattern types rather than String here
inpatterns :: [String]
inpatterns =
  [ "*.tar*" -- TODO GlobOne: glob and invoke once per match
  ]

outpaths :: [String] -> [String]
outpaths inpaths = [dropExtension $ head inpaths]

describe :: [String] -> [String] -> String
describe inpaths outpaths = unwords ["untar", inpath, "->", outpath]
  where
    inpath  = "'" ++ head inpaths  ++ "'"
    outpath = "'" ++ head outpaths ++ "'"

guard :: [String] -> [String] -> Bool
guard inpaths outpaths
  =  (length inpaths  == 1)
  && (length outpaths == 1)
