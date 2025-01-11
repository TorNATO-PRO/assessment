module Section.Two.DiggityDog.Capability.GetBreeds where

import Prelude

import Data.Either (Either)
import Halogen (lift)
import Halogen.Hooks (HookM)
import Section.Two.DiggityDog.Data.BreedList (DogBreeds)

class Monad m <= GetBreeds m where
  getBreeds :: m (Either String DogBreeds)

instance GetBreeds m => GetBreeds (HookM m) where
  getBreeds = lift getBreeds
