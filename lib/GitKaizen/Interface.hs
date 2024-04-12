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
prop_additionCommutative :: Int -> Int -> Bool
prop_additionCommutative a b = a + b == b + a

-- Tasty TestTree
test_multiplication :: [TestTree]
test_multiplication = [testProperty "One is identity" $ \(a :: Int) -> a * 1 == a]
