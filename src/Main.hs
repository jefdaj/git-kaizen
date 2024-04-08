module Main where

import Paths_kaizen

main :: IO ()
main = do
  usage <- readFile =<< getDataFileName "usage.txt"
  putStrLn usage
