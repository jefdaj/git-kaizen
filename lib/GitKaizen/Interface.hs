{-# LANGUAGE ScopedTypeVariables #-}

module GitKaizen.Interface

  -- git-kaizen interface
  ( Kaizen(..)
  -- , Script(..)
  , ListInputsFn
  -- , ListOutputsFn
  -- , MainScriptFn
  -- , InPattern(..)
  , Priority(..)
  , runInRepo

  -- git-kaizen test machinery
  , prop_additionCommutativeInterface
  , test_multiplicationInterface

  -- re-export common utilities
  , takeBaseName
  , dropExtension
  , (</>)

  )
  where

import GitKaizen.Types

import Test.Tasty (TestTree)
import Test.Tasty.QuickCheck (testProperty)

import System.FilePath.Posix ((</>), takeBaseName, dropExtension)

import System.Process -- TODO specifics

runInRepo :: FilePath -> String -> [String] -> IO String
runInRepo repoDir cmd args =
  -- TODO catch and wrap IOErrors here?
  readCreateProcess ((proc cmd args) { cwd=Just repoDir }) ""

-- QuickCheck property
prop_additionCommutativeInterface :: Int -> Int -> Bool
prop_additionCommutativeInterface a b = a + b == b + a

-- Tasty TestTree
test_multiplicationInterface :: [TestTree]
test_multiplicationInterface = [testProperty "One is identity" $ \(a :: Int) -> a * 1 == a]
