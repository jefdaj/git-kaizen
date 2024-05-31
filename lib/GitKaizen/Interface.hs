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

-- QuickCheck property
prop_additionCommutativeInterface :: Int -> Int -> Bool
prop_additionCommutativeInterface a b = a + b == b + a

-- Tasty TestTree
test_multiplicationInterface :: [TestTree]
test_multiplicationInterface = [testProperty "One is identity" $ \(a :: Int) -> a * 1 == a]
