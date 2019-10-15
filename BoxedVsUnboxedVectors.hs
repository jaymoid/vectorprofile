module Main where

import Criterion.Main (defaultMain, bench, whnf)
import qualified Data.Vector as B
import qualified Data.Vector.Unboxed as U


nums :: [Int]
nums = [1..10000]

boxed :: B.Vector Int  
boxed = {-# SCC boxed #-} B.fromList nums

unboxed :: U.Vector Int
unboxed = {-# SCC unboxed #-} U.fromList nums

--  SCC? 
-- https://www.fpcomplete.com/blog/2016/05/weigh-package

main :: IO ()
main = defaultMain
  [ bench "Boxed Vector:" $ whnf (B.map (*2)) boxed
  , bench "Unboxed Vector" $ whnf (U.map (*2)) unboxed -- not a functor! :( 
  ]

-- benchmarking Boxed Vector:
-- time                 419.0 μs   (416.4 μs .. 422.4 μs)
--                      0.999 R²   (0.999 R² .. 1.000 R²)
-- mean                 427.8 μs   (424.5 μs .. 433.3 μs)
-- std dev              14.90 μs   (9.189 μs .. 23.77 μs)
-- variance introduced by outliers: 28% (moderately inflated)

-- benchmarking Unboxed Vector
-- time                 1.364 ms   (1.336 ms .. 1.391 ms)
--                      0.997 R²   (0.997 R² .. 0.998 R²)
-- mean                 1.298 ms   (1.283 ms .. 1.317 ms)
-- std dev              56.56 μs   (48.35 μs .. 66.27 μs)
-- variance introduced by outliers: 31% (moderately inflated)
