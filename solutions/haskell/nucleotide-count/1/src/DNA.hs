module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as M
import Control.Monad

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (M.Map Nucleotide Int)
nucleotideCounts = foldM f M.empty
  where
    nucleotides = zip ['A', 'C', 'G', 'T'] [A, C, G, T]
    insert map nucleo = M.insertWith (+) nucleo 1 map
    f map = maybe (Left "error") (Right . insert map) . flip lookup nucleotides
