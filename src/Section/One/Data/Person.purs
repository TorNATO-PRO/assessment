module Section.One.Data.Person
  ( Person
  , firstName
  , lastName
  , maritalStatus
  , person
  , phoneNumber
  , ssn
  )
  where


import Data.List as List
import Data.String.NonEmpty.Internal (NonEmptyString)
import Data.Validation.Semigroup (V)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Person.Ephemeral (EphemeralPerson)
import Section.One.Data.Person.PhoneNumber (USPhoneNumber)
import Section.One.Data.Person.SSN (SSN)

-- The requirements do not specify anything special for
-- the names (outside of the obvious - that it can't be empty).
newtype Person = Person
    { firstName :: NonEmptyString
    , lastName :: NonEmptyString
    , ssn :: SSN
    , maritalStatus :: Boolean
    , phoneNumber :: USPhoneNumber
    }

person :: EphemeralPerson -> V (List.List String) Person
person _ = unsafeThrow "Unimplemented"

firstName :: Person -> NonEmptyString
firstName (Person rec) = rec.firstName

lastName :: Person -> NonEmptyString
lastName (Person rec) = rec.lastName

ssn :: Person -> SSN
ssn (Person rec) = rec.ssn

maritalStatus :: Person -> Boolean
maritalStatus (Person rec) = rec.maritalStatus

phoneNumber :: Person -> USPhoneNumber
phoneNumber (Person rec) = rec.phoneNumber