module Section.One.Data.Person.PhoneNumber.AreaCode where

import Prelude

import Data.Either (Either)
import Data.Foldable (fold)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Digit (Digit)
import Section.One.Data.Digit as Digit

data AreaCode = AreaCode Digit Digit Digit

areaCode :: String -> Either String AreaCode
areaCode _ = unsafeThrow "Unimplemeted"

areaCodeValue :: AreaCode -> String
areaCodeValue (AreaCode a b c) = fold (Digit.toString <$> [ a, b, c ])

firstDigit :: AreaCode -> Digit
firstDigit (AreaCode a _ _) = a

secondDigit :: AreaCode -> Digit
secondDigit (AreaCode _ b _) = b

thirdDigit :: AreaCode -> Digit
thirdDigit (AreaCode _ _ c) = c

