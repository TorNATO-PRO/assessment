module Section.One.Data.Person.SSN.SerialNumber
  ( Serial
  , firstDigit
  , fourthDigit
  , secondDigit
  , serial
  , serialValue
  , thirdDigit
  )
  where

import Prelude

import Data.Array (intercalate)
import Data.Either (Either)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Digit (Digit)
import Section.One.Data.Digit as Digit

data Serial = Serial Digit Digit Digit Digit

serial :: String -> Either String Serial
serial _ = unsafeThrow "Unimplemented"

serialValue :: Serial -> String
serialValue (Serial a b c d) = intercalate "" (Digit.toString <$> [a,b,c,d])

firstDigit :: Serial -> Digit
firstDigit (Serial a _ _ _) = a

secondDigit :: Serial -> Digit
secondDigit (Serial _ b _ _) = b

thirdDigit :: Serial -> Digit
thirdDigit (Serial _ _ c _) = c

fourthDigit :: Serial -> Digit
fourthDigit (Serial _ _ _ d) = d
