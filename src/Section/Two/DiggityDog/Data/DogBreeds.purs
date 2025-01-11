module Section.Two.DiggityDog.Data.BreedList
  ( DogBreeds(..)
  , breeds
  , subBreeds
  ) where

import Prelude

import Data.Argonaut (class DecodeJson, JsonDecodeError(..), decodeJson, encodeJson, (.:))
import Data.Either (Either(..))
import Data.Map as Map
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Newtype (class Newtype)
import Data.Set (Set)
import Data.String.NonEmpty (NonEmptyString)
import Data.String.NonEmpty as NES
import Data.Traversable (for)
import Data.Tuple (Tuple(..))
import Foreign.Object (Object)
import Foreign.Object as Object

newtype DogBreeds = DogBreeds (Map.Map NonEmptyString (Array NonEmptyString))

derive instance Eq DogBreeds

derive instance Newtype DogBreeds _

instance DecodeJson DogBreeds where
  decodeJson json = do
    obj <- decodeJson json
    -- this type annotation is not strictly necessary, but I find it helpful
    (message :: Object (Array String)) <- obj .: "message"
    let (breeds :: Array (Tuple String (Array String))) = Object.toAscUnfoldable message
    case for breeds parsePair of
      Nothing -> Left (AtKey "Message" (UnexpectedValue (encodeJson message)))
      Just dogBreeds -> pure (DogBreeds $ Map.fromFoldable dogBreeds)
    where
    parsePair :: (Tuple String (Array String)) -> Maybe (Tuple NonEmptyString (Array NonEmptyString))
    parsePair (Tuple breed sBreeds) = do
      dogBreed <- NES.fromString breed
      dogSubBreeds <- for sBreeds NES.fromString
      pure (Tuple dogBreed dogSubBreeds)

subBreeds :: DogBreeds -> NonEmptyString -> Array NonEmptyString
subBreeds (DogBreeds brds) breed = fromMaybe [] $ Map.lookup breed brds

breeds :: DogBreeds -> Set NonEmptyString
breeds (DogBreeds brds) = Map.keys brds
