module Lib.Types where

data InPattern
    = GlobOne String

data Task = Task
    { taskName       :: String
    , taskInPatterns :: [InPattern]
    , taskOutPaths   :: [String] -> [String]
    , taskDescribe   :: [String] -> [String] -> String
    , taskGuard      :: [String] -> [String] -> IO Bool
    -- TODO actual command.. shelly? turtle? system thing?
    , taskCommand    :: [String] -> [String] -> IO ()
    }
