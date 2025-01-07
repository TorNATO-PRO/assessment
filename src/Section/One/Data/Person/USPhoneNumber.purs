module Section.One.Data.Person.PhoneNumber where

import Data.Either (Either)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Person.PhoneNumber.AreaCode (AreaCode)
import Section.One.Data.Person.PhoneNumber.LineNumber (LineNumber)
import Section.One.Data.Person.PhoneNumber.Prefix (Prefix)

data USPhoneNumber = USPhoneNumber AreaCode Prefix LineNumber

usPhoneNumber :: String -> Either String USPhoneNumber
usPhoneNumber _ = unsafeThrow "Unimplemented"

areaCode :: USPhoneNumber -> AreaCode
areaCode (USPhoneNumber a _ _) = a

prefix :: USPhoneNumber -> Prefix
prefix (USPhoneNumber _ p _) = p

lineNumber :: USPhoneNumber -> LineNumber
lineNumber (USPhoneNumber _ _ l) = l

