{-# LANGUAGE QuasiQuotes #-}

module Main where

import Paths_kaizen
import System.Environment (getArgs)
import System.Console.Docopt

patterns :: Docopt
patterns = [docoptFile|usage.txt|]

getArgOrExit = getArgOrExitWith patterns

main :: IO ()
main = do
  args <- parseArgsOrExit patterns =<< getArgs
  print args
