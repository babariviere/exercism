module CollatzConjecture
  ( collatz
  )
where

collatz :: Integer -> Maybe Integer
collatz x
  | x == 1    = Just 0
  | x < 1     = Nothing
  | otherwise = Just $ collatzRec x 0

collatzRec :: Integer -> Integer -> Integer
collatzRec x count
  | x == 1    = count
  | even x    = collatzRec (x `quot` 2) (count + 1)
  | otherwise = collatzRec (x * 3 + 1) (count + 1)
