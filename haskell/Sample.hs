module Sample where

digits :: Int -> Int
digits = length . show

square :: Num a => a -> a
square = (^ 2)

ultimate :: Int -> String
ultimate 42 = "人生、宇宙、全ての答え"
ultimate n = show n

maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just a) = [a]

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (a : as) = Just a

deeping :: String -> String
deeping s@(' ':' ':_) = "  " ++ s
deeping s@(' ':_) = " " ++ s
deeping s = s

judgeNumber :: Num a => a -> String
judgeNumber a = "int"
-- judgeNumber a = "double"

safeSqrt :: (Ord a, Floating a) => a -> Maybe a
safeSqrt x
  | x < 0 = Nothing
  | otherwise = Just (sqrt x)


caseOfFirstLetter :: String -> String
caseOfFirstLetter "" = "empty"
caseOfFirstLetter (x:xs)
  | inRange 'a' 'z' = "lower"
  | inRange 'A' 'Z' = "upper"
  | otherwise = "other"
  where
    inRange lower upper = lower <= x && x <= upper

fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fib' :: Int -> [Int]
fib' 0 = [1]
fib' 1 = [1] ++ fib' 0
fib' n = [(fib (n))] ++ fib' (n-1)

length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + length' xs

take' :: Int -> [a] -> [a]
take' n _ | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : take' (n-1) xs

drop' :: Int -> [a] -> [a]
drop' n xs | n <= 0 = xs
drop' _ [] = []
drop' n (_:xs) = drop' (n-1) xs

ins :: Ord a => a -> [a] -> [a]
ins e [] = [e]
ins e (x:xs)
  | e < x = e : x : xs
  | otherwise = x : ins e xs

insSort :: Ord a => [a] -> [a]
insSort [] = []
insSort (x:xs) = ins x (insSort xs)

each :: (a -> b) -> (c -> d) -> (a, c) -> (b, d)
each f g (x, y) = (f x, g y)

segments :: [a] -> [[a]]
segments = foldr (++) [] . scanr (\a b -> [a] : map (a:) b) []

tarai :: Int -> Int -> Int -> Int
tarai x y z
  | x <= y = y
  | otherwise = tarai (tarai (x-1) y z) (tarai (y-1) z x) (tarai (z-1) x y)
