module Section.Two.DiggityDog.Capability.GetBreedDetails where

import Prelude

import Data.Either (Either)
import Data.String.NonEmpty (NonEmptyString)
import Halogen (lift)
import Halogen.Hooks (HookM)
import Section.Two.DiggityDog.Data.BreedImages (BreedImages)

class Monad m <= GetBreedDetails m where
  getBreedDetails :: NonEmptyString -> m (Either String BreedImages)

instance GetBreedDetails m => GetBreedDetails (HookM m) where
  getBreedDetails = lift <<< getBreedDetails
