{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Paths_file_kaizen
import System.Environment (getArgs)
import System.Console.Docopt
import Dhall
import Text.Pretty.Simple (pPrint)
import Control.Monad (when)
import qualified Data.Text.IO as TIO

patterns :: Docopt
patterns = [docoptFile|usage.txt|]

getArgOrExit = getArgOrExitWith patterns

-- data Person = Person { age :: Natural, name :: Text }
--     deriving (Generic, FromDhall, Show)

data InPattern = GlobOne Text
    deriving (Generic, FromDhall, Show)

data Task = Task
    { name :: Text
    , inpatterns :: [InPattern]
    , outpaths :: [Text] -> [Text]
    -- , describe :: [Text] -> [Text] -> Text
    }
    deriving (Generic, FromDhall)

cmdCheck :: FilePath -> IO ()
cmdCheck file = do
  expr <- TIO.readFile file
  (x :: Task) <- input auto expr
  print $ name x

main :: IO ()
main = do
  args <- parseArgsOrExit patterns =<< getArgs
  print args
  when (args `isPresent` (command "check")) $ do
    file <- args `getArgOrExit` (argument "dhallfile")
    cmdCheck file
