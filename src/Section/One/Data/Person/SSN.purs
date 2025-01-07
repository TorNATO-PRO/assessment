module Section.One.Data.Person.SSN
  ( SSN(..)
  , area
  , group
  , serial
  , ssn
  )
  where

import Data.Either (Either)
import Effect.Exception.Unsafe (unsafeThrow)
import Section.One.Data.Person.SSN.Area (Area)
import Section.One.Data.Person.SSN.GroupNumber (Group)
import Section.One.Data.Person.SSN.SerialNumber (Serial)

data SSN = SSN Area Group Serial

ssn :: String -> Either String SSN
ssn _ = unsafeThrow "Unimplemented"

area :: SSN -> Area
area (SSN a _ _) = a

group :: SSN -> Group
group (SSN _ g _) = g

serial :: SSN -> Serial
serial (SSN _ _ s) = s
