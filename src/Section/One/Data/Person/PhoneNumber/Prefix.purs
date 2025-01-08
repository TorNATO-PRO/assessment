module Section.One.Data.Person.PhoneNumber.Prefix where

import Prelude

import Data.Either (Either)
import Data.Foldable (fold)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Digit (Digit)
import Section.One.Data.Digit as Digit

data Prefix = Prefix Digit Digit Digit

prefix :: String -> Either String Prefix
prefix _ = unsafeThrow "Unimplemeted"

areaCodeValue :: Prefix -> String
areaCodeValue (Prefix a b c) = fold (Digit.toString <$> [ a, b, c ])

firstDigit :: Prefix -> Digit
firstDigit (Prefix a _ _) = a

secondDigit :: Prefix -> Digit
secondDigit (Prefix _ b _) = b

thirdDigit :: Prefix -> Digit
thirdDigit (Prefix _ _ c) = c

