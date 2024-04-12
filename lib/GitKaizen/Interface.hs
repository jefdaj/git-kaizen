{-# LANGUAGE ScopedTypeVariables #-}

module GitKaizen.Interface where
  -- ( Kaizen(..)
  -- , InPattern(..)
  -- , Priority(..)
  -- )
  -- where

import GitKaizen.Types

import Test.Tasty
import Test.Tasty.QuickCheck

-- QuickCheck property
prop_additionCommutativeInterface :: Int -> Int -> Bool
prop_additionCommutativeInterface a b = a + b == b + a

-- Tasty TestTree
test_multiplicationInterface :: [TestTree]
test_multiplicationInterface = [testProperty "One is identity" $ \(a :: Int) -> a * 1 == a]
