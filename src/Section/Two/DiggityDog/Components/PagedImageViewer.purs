module Section.Two.DiggityDog.Components.PagedImageViewer
  ( Props
  , component
  ) where

import Prelude

import Data.Array (slice)
import Data.Array as Array
import Data.String.NonEmpty as NES
import Data.Tuple (Tuple(..))
import Halogen (ClassName(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.Hooks (HookM)
import Halogen.Hooks as Hooks
import Section.Two.DiggityDog.Components.NavButton as NavButton
import Section.Two.DiggityDog.Data.BreedImages (BreedImages, breedImages)
import Type.Proxy (Proxy(..))

pageSize :: Int
pageSize = 20

type Props =
  { images :: BreedImages
  }

data BackButtonAction = Back

data NextButtonAction = Next

_backButton :: Proxy "backButton"
_backButton = Proxy

_nextButton :: Proxy "nextButton"
_nextButton = Proxy

component :: forall q m a. H.Component q Props a m
component = Hooks.component \_ { images } -> Hooks.do
  Tuple currentPage currentPageId <- Hooks.useState 0

  let
    handleBackClicked :: BackButtonAction -> HookM m Unit
    handleBackClicked Back = Hooks.put currentPageId (max 0 (currentPage - 1))

    numImages :: Int
    numImages = Array.length $ breedImages images

    startIndex :: Int
    startIndex = (currentPage * pageSize) + 1

    endIndex :: Int
    endIndex = min numImages (startIndex + pageSize - 1)

    handleNextClicked :: NextButtonAction -> HookM m Unit
    handleNextClicked Next = unless ((currentPage + 1) * pageSize >= numImages) do
      Hooks.put currentPageId (currentPage + 1)

  Hooks.pure do
    HH.div_
      [ HH.p_ [ HH.text $ "Displaying " <> show startIndex <> "-" <> show endIndex <> " of " <> show numImages ]
      , HH.div
          [ HP.class_ $ ClassName "image-container" ]
          ((page currentPage $ breedImages images) <#> \image -> HH.img [ HP.src $ NES.toString image, HP.class_ $ ClassName "image" ])
      , HH.div
          [ HP.class_ $ ClassName "image-nav-container"

          ]
          [ HH.slot _backButton unit NavButton.component { title: "Previous", disabled: currentPage <= 0, onClick: Back } handleBackClicked
          , HH.slot _nextButton unit NavButton.component { title: "Next", disabled: (currentPage + 1) * pageSize >= numImages, onClick: Next } handleNextClicked
          ]
      ]
  where
  page idx = slice (idx * pageSize) ((idx + 1) * pageSize)