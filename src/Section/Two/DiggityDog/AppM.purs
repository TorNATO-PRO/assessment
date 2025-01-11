module Section.Two.DiggityDog.AppM
  ( AppM(..)
  , runAppM
  )
  where

import Prelude

import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (class MonadEffect)
import Effect.Class.Console as Console
import Section.Two.DiggityDog.API.DogCEO as API
import Section.Two.DiggityDog.Capability.GetBreedDetails (class GetBreedDetails)
import Section.Two.DiggityDog.Capability.GetBreeds (class GetBreeds)
import Section.Two.DiggityDog.Capability.LogMessage (class LogMessage)

newtype AppM a = AppM (Aff a)

derive newtype instance Functor AppM

derive newtype instance Apply AppM

derive newtype instance Applicative AppM

derive newtype instance Bind AppM

derive newtype instance Monad AppM

derive newtype instance MonadEffect AppM

derive newtype instance MonadAff AppM

runAppM :: AppM ~> Aff
runAppM (AppM m)= m

instance LogMessage AppM where
  logMessage msg = Console.log msg

instance GetBreedDetails AppM where
  getBreedDetails = liftAff <<< API.getBreedDetails

instance GetBreeds AppM where
  getBreeds = liftAff API.getBreeds