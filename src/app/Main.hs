{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

{-
Note that this is the only module where we can't embed Tasty tests,
because the generated tasty-discover module also calls itself Main.
So I try to keep it minimal and move all non-trivial code elsewhere.
TODO is that my own misconfiguration? is it fixable? open an issue with tasty-discover
-}

module Main where

import Load
import GitKaizen.Types
import Paths_git_kaizen

import System.Environment (getArgs)
import System.Console.Docopt
-- import Dhall
import Text.Pretty.Simple (pPrint)
import Control.Monad (when)
import qualified Data.Text.IO as TIO

import Colog.Core (LogAction (..), (<&), logStringStdout)

patterns :: Docopt
patterns = [docoptFile|usage.txt|]

getArgOrExit = getArgOrExitWith patterns

-- | Does this also go in the Haddock, maybe somewhere else?
--   Ah, this is just recently fixed in Stack so it's coming soon.
--   Should be able to start writing the comments and assume it'll work.
main :: IO ()
main = do

  logStringStdout <& "starting main"

  args <- parseArgsOrExit patterns =<< getArgs
  print args

  when (args `isPresent` (command "load")) $ do
    kaizenDir <- args `getArgOrExit` (argument "kaizendir")
    kaizens <- loadKaizens kaizenDir
    putStrLn $ "kaizens: " ++ show (map (\(a,b) -> (kzName a, b)) kaizens)

  logStringStdout <& "finished main"
