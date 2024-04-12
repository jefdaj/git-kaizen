{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import GitKaizen.Types
import GitKaizen.Load
import Paths_git_kaizen

import System.Environment (getArgs)
import System.Console.Docopt
-- import Dhall
import Text.Pretty.Simple (pPrint)
import Control.Monad (when)
import qualified Data.Text.IO as TIO

patterns :: Docopt
patterns = [docoptFile|usage.txt|]

getArgOrExit = getArgOrExitWith patterns

-- | Does this also go in the Haddock, maybe somewhere else?
--   Ah, this is just recently fixed in Stack so it's coming soon.
--   Should be able to start writing the comments and assume it'll work.
main :: IO ()
main = do
  args <- parseArgsOrExit patterns =<< getArgs
  print args

  when (args `isPresent` (command "load")) $ do
    kaizenDir <- args `getArgOrExit` (argument "kaizendir")
    kaizens <- loadKaizens kaizenDir
    putStrLn $ "kaizens: " ++ show (map (\(a,b) -> (kzName a, b)) kaizens)
