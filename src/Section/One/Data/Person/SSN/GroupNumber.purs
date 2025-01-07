module Section.One.Data.Person.SSN.GroupNumber
  ( Group
  , firstDigit
  , group
  , groupValue
  , secondDigit
  )
  where

import Prelude

import Data.Array (intercalate)
import Data.Either (Either)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Digit (Digit)
import Section.One.Data.Digit as Digit

data Group = Group Digit Digit

group :: String -> Either String Group
group _ = unsafeThrow "Unimplemented"

groupValue :: Group -> String
groupValue (Group a b) = intercalate "" (Digit.toString <$> [ a, b ])

firstDigit :: Group -> Digit
firstDigit (Group a _) = a

secondDigit :: Group -> Digit
secondDigit (Group _ b) = b
