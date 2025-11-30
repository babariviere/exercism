module Pangram (isPangram) where

import Data.Char
import Data.List

isPangram :: String -> Bool
isPangram text = null $ ['a'..'z'] \\ map toLower text
