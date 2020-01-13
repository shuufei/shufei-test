module Main where

total :: Num a => [a] -> a
total xs = total' 0 xs where
  total' acc [] = acc
  total' acc (x:xs) = total' (acc + x) xs


main :: IO ()
main = print $ total [1..10^7]
