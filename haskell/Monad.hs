module MonadoTest where
import Control.Monad.Reader
import Control.Monad.Writer
import Control.Monad.State

square :: Integer -> Maybe Integer
square n
  | 0 <= n = Just (n*n)
  | otherwise = Nothing


squareRoot :: Integer -> Maybe Integer
squareRoot n
  | 0 <= n = squareRoot' 1
  | otherwise = Nothing
  where
    squareRoot' x
      | n > x*x = squareRoot' (x+1)
      | n < x*x = Nothing
      | otherwise = Just x

squareAndSquareRoot1 :: Integer -> Maybe Integer
squareAndSquareRoot1 n = do
  nn <- square n
  squareRoot nn

squareAndSquareRoot2 :: Integer -> Integer -> Maybe Integer
squareAndSquareRoot2 m n = do
  mm <- square m
  nn <- square n
  squareRoot (mm * nn)

lessThan :: Integer -> [Integer]
lessThan n = [0..n-1]

plusMinus :: Integer -> Integer -> [Integer]
plusMinus a b = [a+b, a-b]

-- allPM0s :: Integer -> [Integer]
-- allPM0s n = concat (map (plusMinus 0) (lessThan n))

allPM0s :: Integer -> [Integer]
allPM0s n = do
  x <- lessThan n
  plusMinus 0 x


allPMs m n = do
  x <- lessThan m
  y <- lessThan n
  plusMinus x y

countOdd :: [Int] -> Int
countOdd = length . filter odd

countEven :: [Int] -> Int
countEven = length . filter even

-- countAll :: [Int] -> Int
-- countAll xs = countOdd xs + countEven xs

countAll :: [Int] -> Int
countAll = do
  odds <- countOdd
  evens <- countEven
  return (odds + evens)


triple :: Int -> Int
triple = do
  n <- id
  d <- (n+)
  (d+)


data Config = Config {
  verbose :: Int
  , debug :: Bool
}

configToLevel :: Config -> Int
configToLevel config
  | debug config = 10
  | otherwise = verbose config

outputLevel :: Reader Config [Int]
outputLevel = do
  config <- ask
  return [1..configToLevel config]

output :: Int -> String -> Reader Config (Maybe String)
output level str = do
  ls <- outputLevel
  return (if level `elem` ls then Just str else Nothing)


enable :: (a -> a) -> Writer (Endo a) ()
enable = tell . Endo

plusEvenMinusOdd :: [Int] -> Writer (Endo Int) ()
plusEvenMinusOdd [] = return ()
plusEvenMinusOdd (n:ns) = do
  enable (\x -> if even n then x + n else x - n)
  plusEvenMinusOdd ns

push :: a -> [a] -> ((), [a])
push value stack = ((), value:stack)

push' :: a -> State [a] ()
push' = modify . (:)

pop :: [a] -> (a, [a])
pop (value:stack) = (value, stack)

pop' :: State [a] a
pop' = do
  value <- gets head
  modify tail
  return value

applyTop :: (a -> a) -> [a] -> ((), [a])
applyTop f stack = let (a, stack1) = pop stack;
                       (_, stack2) = push (f a) stack1
  in ((), stack2)

applyTop' :: (a -> a) -> State [a] ()
applyTop' f = do
  a <- pop'
  push' (f a)
