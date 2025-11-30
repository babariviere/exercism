module Pangram (isPangram) where

import qualified Data.HashSet as Set
import Data.Char

isPangram :: String -> Bool
isPangram text | length text < 26 = False
               | otherwise = Set.size(getLetters Set.empty text) == 26

getLetters :: Set.HashSet Char -> String -> Set.HashSet Char
getLetters set [] = set
getLetters set (x : xs) | Set.size set == 26 = set
                        | x `elem` ['a'..'z'] = getLetters (Set.insert x set) xs
                        | x `elem` ['A'..'Z'] = getLetters (Set.insert (toLower x) set) xs
                        | otherwise = getLetters set xs
