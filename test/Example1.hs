{-# LANGUAGE ScopedTypeVariables #-}

module Example1 where

import Test.Tasty
import Test.Tasty.QuickCheck

-- QuickCheck property
prop_additionCommutative :: Int -> Int -> Bool
prop_additionCommutative a b = a + b == b + a

-- Tasty TestTree
test_multiplication :: [TestTree]
test_multiplication = [testProperty "One is identity" $ \(a :: Int) -> a * 1 == a]
