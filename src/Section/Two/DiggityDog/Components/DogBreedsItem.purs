module Section.Two.DiggityDog.Components.DogBreedsItem
  ( BreedItemMessage(..)
  , Props
  , component
  ) where

import Prelude

import Data.String.NonEmpty as NES
import Data.String.NonEmpty.Internal (NonEmptyString)
import Data.Tuple (Tuple(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.Hooks as Hook
import Halogen.Hooks as Hooks

type Props =
  { dogBreedPair :: (Tuple NonEmptyString (Array NonEmptyString))
  }

data BreedItemMessage = BreedClicked NonEmptyString

component :: forall q m. H.Component q Props BreedItemMessage m
component = Hooks.component \{ outputToken } { dogBreedPair } -> Hooks.do
  let
    (Tuple breed subBreeds) = dogBreedPair

    handleClick b = Hook.raise outputToken (BreedClicked b)

  Hooks.pure do
    HH.li_
      [ HH.a [ HE.onClick \_ -> handleClick breed ] [ HH.text $ NES.toString breed ]
      , HH.ul_
          ( subBreeds <#> \subBreed ->
              HH.li_
                [ HH.a [ HE.onClick \_ -> handleClick subBreed ] [ HH.text $ NES.toString subBreed ]
                ]
          )
      ]