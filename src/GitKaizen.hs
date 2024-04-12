{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import GitKaizen.Types
import GitKaizen.Plugins
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

main :: IO ()
main = do
  args <- parseArgsOrExit patterns =<< getArgs
  print args
  putStrLn $ "plugins: " ++ show (map taskName plugins)
