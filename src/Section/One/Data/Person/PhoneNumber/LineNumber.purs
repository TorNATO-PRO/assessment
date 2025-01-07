module Section.One.Data.Person.PhoneNumber.LineNumber where

import Prelude

import Data.Array (intercalate)
import Data.Either (Either)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Digit (Digit)
import Section.One.Data.Digit as Digit

data LineNumber = LineNumber Digit Digit Digit Digit

areaCode :: String -> Either String LineNumber
areaCode _ = unsafeThrow "Unimplemeted"

areaCodeValue :: LineNumber -> String
areaCodeValue (LineNumber a b c d) = intercalate "" (Digit.toString <$> [a, b, c, d])

firstDigit :: LineNumber -> Digit
firstDigit (LineNumber a _ _ _) = a

secondDigit :: LineNumber -> Digit
secondDigit (LineNumber _ b _ _) = b

thirdDigit :: LineNumber -> Digit
thirdDigit (LineNumber _ _ c _) = c

fourthDigit :: LineNumber -> Digit
fourthDigit (LineNumber _ _ _ d) = d

