module Pangram (isPangram) where

import Data.Char
import Data.List

isPangram :: String -> Bool
isPangram text = ['a'..'z'] \\ map toLower text == []
