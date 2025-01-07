module Section.One.Data.Person.SSN.Area
  ( Area(..)
  , area
  , areaValue
  , firstDigit
  , secondDigit
  , thirdDigit
  )
  where

import Prelude

import Data.Array (intercalate)
import Data.Either (Either)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Digit (Digit)
import Section.One.Data.Digit as Digit

-- so as far as I am aware, 000 is possible?
-- that is why I decided to make the constructor public
data Area = Area Digit Digit Digit

area :: String -> Either String Area
area _ = unsafeThrow "Unimplemented"

areaValue :: Area -> String
areaValue (Area a b c) = intercalate "" (Digit.toString <$> [ a, b, c ])

firstDigit :: Area -> Digit
firstDigit (Area a _ _) = a

secondDigit :: Area -> Digit
secondDigit (Area _ b _) = b

thirdDigit :: Area -> Digit
thirdDigit (Area _ _ c) = c

