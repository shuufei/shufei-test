module Lazy where

nats :: [Integer]
nats = 0 : map (+1) nats

fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

data Tree a = Leaf { element :: a }
  | Fork { element :: a
    , left :: Tree a
    , right :: Tree a
  } deriving Show

dtree :: Tree Integer
dtree = dtree' 0 where
  dtree' depth = Fork { element = depth
    , left = dtree' (depth + 1)
    , right = dtree' (depth + 1)
    }


mean :: [Double] -> Double
mean xs = sum xs / fromIntegral (length xs)

mean' :: [Double] -> Double
mean' xs = let (res, len) = foldl (\(m, n) x -> (m + x / len, n + 1)) (0, 0) xs in res
