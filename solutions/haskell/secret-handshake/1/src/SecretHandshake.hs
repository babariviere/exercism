module SecretHandshake (handshake) where

import Data.Bits
import Data.Maybe

fromBool :: Bool -> a -> Maybe a
fromBool False _ = Nothing
fromBool True  a = Just a

handshake :: Int -> [String]
handshake 0 = []
handshake x = maybeRev $ map fromJust $ filter isJust [wink, doubleBlink, closeYourEyes, jump]
 where
  wink          = fromBool (testBit x 0) "wink"
  doubleBlink   = fromBool (testBit x 1) "double blink"
  closeYourEyes = fromBool (testBit x 2) "close your eyes"
  jump          = fromBool (testBit x 3) "jump"
  maybeRev      = fromMaybe id (fromBool (testBit x 4) reverse)
