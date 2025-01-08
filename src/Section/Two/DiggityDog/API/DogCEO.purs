module Section.Two.DiggityDog.API.DogCEO where

import Prelude

import Affjax (printError)
import Affjax.ResponseFormat (json)
import Affjax.Web (get)
import Data.Argonaut (decodeJson, printJsonDecodeError)
import Data.Bifunctor (lmap)
import Data.Either (Either)
import Data.Foldable (fold)
import Data.String.NonEmpty (NonEmptyString)
import Data.String.NonEmpty as NES
import Effect.Aff (Aff)
import Section.Two.DiggityDog.Data.BreedImages (BreedImages)
import Section.Two.DiggityDog.Data.BreedList (DogBreeds)

getBreeds :: Aff (Either String DogBreeds)
getBreeds = do
  breedsE <- get json " https://dog.ceo/api/breeds/list/all"
  pure $ lmap printError breedsE >>= \resp -> lmap printJsonDecodeError (decodeJson resp.body)

getBreedDetails :: NonEmptyString -> Aff (Either String BreedImages)
getBreedDetails breed = do
  detailsE <- get json (fold ["http://dog.ceo/api/breed/", NES.toString breed, "/images"])
  pure $ lmap printError detailsE >>= \resp -> lmap printJsonDecodeError (decodeJson resp.body)