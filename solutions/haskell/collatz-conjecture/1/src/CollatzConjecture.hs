module CollatzConjecture
  ( collatz
  )
where

collatz :: Integer -> Maybe Integer
collatz x | x == 1    = Just 0
          | x < 1     = Nothing
          | even x    = (+ 1) <$> (collatz $ x `div` 2)
          | otherwise = (+ 1) <$> (collatz $ x * 3 + 1)
