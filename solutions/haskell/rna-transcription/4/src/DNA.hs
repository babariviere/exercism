module DNA (toRNA) where

import Control.Monad
import Data.Maybe

toRNA :: String -> Either Char String
toRNA = fmap reverse . foldM f ""
  where
    dnaToRNA = zip ['G', 'C', 'T', 'A'] ['C', 'G', 'A', 'U']
    f str c = maybe (Left c) (Right . flip (:) str) $ lookup c dnaToRNA
