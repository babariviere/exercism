module Bob (responseFor) where

import Data.Char (toUpper, toLower, isSpace)

import Data.List  (dropWhile, dropWhileEnd)

responseFor :: String -> String
responseFor xs
  | null text             = "Fine. Be that way!"
  | yellingP && questionP = "Calm down, I know what I'm doing!"
  | yellingP              = "Whoa, chill out!"
  | questionP             = "Sure."
  | otherwise             = "Whatever."
 where
  text      = (dropWhile isSpace . dropWhileEnd isSpace) xs
  uppercase = map toUpper text
  yellingP  = map toLower text /= uppercase && uppercase == text
  questionP = last text == '?'
