module Brackets (arePaired) where

arePaired :: String -> Bool
arePaired []         = True
arePaired (x:xs)
  | x `elem` open = maybe False arePaired (matchPair x xs)
  | x `elem` close = False
  | otherwise = arePaired xs

open :: String
open = "([{"

close :: String
close = ")]}"

lookupPair :: Char -> Maybe Char
lookupPair c = lookup c $ zip open close

matchPair :: Char -> String -> Maybe String
matchPair _   []         = Nothing
matchPair c (x:xs)
 | lookupPair c == Just x = Just xs
 | x `elem` open = matchPair x xs >>= matchPair c
 | x `elem` close = Nothing
 | otherwise = matchPair c xs
