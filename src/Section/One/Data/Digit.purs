module Section.One.Data.Digit
  ( Digit(..)
  , fromInt
  , fromString
  , toInt
  , toString
  ) where

import Prelude

import Data.Maybe (Maybe(..))

data Digit
  = Zero
  | One
  | Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine

derive instance Eq Digit

derive instance Ord Digit

instance Bounded Digit where
  top :: Digit
  top = Nine

  bottom :: Digit
  bottom = Zero

-- making an enum is left as an exercize for the reader

-- I thought of making this a semiring, and
-- realized that wouldnt make sense

toInt :: Digit -> Int
toInt = case _ of
  Zero -> 0
  One -> 1
  Two -> 2
  Three -> 3
  Four -> 4
  Five -> 5
  Six -> 6
  Seven -> 7
  Eight -> 8
  Nine -> 9

fromInt :: Int -> Maybe Digit
fromInt = case _ of
  0 -> Just Zero
  1 -> Just One
  2 -> Just Two
  3 -> Just Three
  4 -> Just Four
  5 -> Just Five
  6 -> Just Six
  7 -> Just Seven
  8 -> Just Eight
  9 -> Just Nine
  _ -> Nothing

-- lets honor the lawful Show
-- The Show type class represents those types which can be converted into a human-readable String representation.

-- While not required, it is recommended that for any expression x, the string show x be executable PureScript code which evaluates to the same value as the expression x.
-- Source: https://pursuit.purescript.org/packages/purescript-prelude/6.0.1/docs/Data.Show#t:Show

toString :: Digit -> String
toString = case _ of
  Zero -> "0"
  One -> "1"
  Two -> "2"
  Three -> "3"
  Four -> "4"
  Five -> "5"
  Six -> "6"
  Seven -> "7"
  Eight -> "8"
  Nine -> "9"

fromString :: String -> Maybe Digit
fromString str = case str of
  "0" -> Just Zero
  "1" -> Just One
  "2" -> Just Two
  "3" -> Just Three
  "4" -> Just Four
  "5" -> Just Five
  "6" -> Just Six
  "7" -> Just Seven
  "8" -> Just Eight
  "9" -> Just Nine
  _ -> Nothing
