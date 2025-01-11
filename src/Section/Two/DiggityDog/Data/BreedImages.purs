module Section.Two.DiggityDog.Data.BreedImages
  ( BreedImages(..)
  , breedImages
  ) where

import Prelude

import Data.Argonaut (class DecodeJson, JsonDecodeError(..), decodeJson, encodeJson, (.:))
import Data.Either (Either(..))
import Data.Newtype (class Newtype, unwrap)
import Data.String.NonEmpty (NonEmptyString)

newtype BreedImages = BreedImages (Array NonEmptyString)

derive instance Eq BreedImages

derive instance Newtype BreedImages _

instance DecodeJson BreedImages where
  decodeJson json = do
    obj <- decodeJson json
    status <- obj .: "status"
    if status /= "success" then
      Left (AtKey "status" (UnexpectedValue (encodeJson status)))
    else do
      message <- obj .: "message"
      pure (BreedImages message)

breedImages :: BreedImages -> Array NonEmptyString
breedImages = unwrap
