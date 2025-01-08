module Section.Two.DiggityDog.Data.BreedImages
  ( BreedImages(..)
  )
  where

import Prelude

import Data.Argonaut (class DecodeJson, JsonDecodeError(..), decodeJson, encodeJson, (.:))
import Data.Either (Either(..))
import Data.Newtype (class Newtype)

newtype BreedImages = BreedImages (Array String)

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
