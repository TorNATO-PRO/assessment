module Section.One.Data.Person.Ephemeral
  ( EphemeralPerson
  ) where

-- for editing, to reduce the amount of pain,
-- I often think it is the best idea to make the
-- type as lose as possible an then proceed to do
-- validation on the result, restricting the types
-- as much as possible and making "illegal states irrepresentable".
type EphemeralPerson =
  { firstName :: String
  , lastName :: String
  , ssn :: String
  , maritalStatus :: Boolean
  , phoneNumber :: String
  }
