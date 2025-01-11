module Section.Two.DiggityDog.Model
  ( Model
  )
  where

import Data.Either (Either)
import Data.Map (Map)
import Data.String.NonEmpty (NonEmptyString)
import Section.Two.DiggityDog.Data.BreedImages (BreedImages)
import Section.Two.DiggityDog.Data.BreedList (DogBreeds)

type Model =
  { dogBreeds :: Either String DogBreeds

  -- lets lazily cache
  , dogBreedImages :: Map NonEmptyString (Either String BreedImages)
  }
