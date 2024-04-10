{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Lib.Types
import qualified Tasks.Untar as Untar
import Paths_file_kaizen

import System.Environment (getArgs)
import System.Console.Docopt
-- import Dhall
import Text.Pretty.Simple (pPrint)
import Control.Monad (when)
import qualified Data.Text.IO as TIO

patterns :: Docopt
patterns = [docoptFile|usage.txt|]

getArgOrExit = getArgOrExitWith patterns

tasks :: [Task]
tasks =
  [ Untar.task
  ]

main :: IO ()
main = do
  args <- parseArgsOrExit patterns =<< getArgs
  print args
  putStrLn $ "tasks: " ++ show (map taskName tasks)
