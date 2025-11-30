module CollatzConjecture
  ( collatz
  )
where

collatz :: Integer -> Maybe Integer
collatz x
  | x == 1    = Just 0
  | x < 1     = Nothing
  | otherwise = collatzRec x 0

collatzRec :: Integer -> Integer -> Maybe Integer
collatzRec x count
  | x == 1    = Just count
  | x < 1     = Nothing
  | even x    = collatzRec (x `div` 2) (count + 1)
  | otherwise = collatzRec (x * 3 + 1) (count + 1)
