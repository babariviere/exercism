module LeapYear (isLeapYear) where

divP :: Integer -> Integer -> Bool
divP a b = (a `mod` b) == 0

isLeapYear :: Integer -> Bool
isLeapYear year
  | not divBy4 = False
  | not divBy100 = True
  | not divBy400 = False
  | otherwise = True
  where 
    divBy4 = divP year 4
    divBy100 = divP year 100
    divBy400 = divP year 400
