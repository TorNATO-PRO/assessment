module Section.Two.DiggityDog.App
  ( component
  ) where

import Prelude

import Control.Monad.Reader (class MonadAsk)
import Data.Array as Array
import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.FunctorWithIndex (mapWithIndex)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.Hooks (HookM)
import Halogen.Hooks as Hooks
import Section.Two.DiggityDog.Capability.GetBreedDetails (class GetBreedDetails, getBreedDetails)
import Section.Two.DiggityDog.Capability.GetBreeds (class GetBreeds, getBreeds)
import Section.Two.DiggityDog.Capability.LogMessage (class LogMessage, logMessage)
import Section.Two.DiggityDog.Components.DogBreedsItem (BreedItemMessage(..))
import Section.Two.DiggityDog.Components.DogBreedsItem as DogBreedsItem
import Section.Two.DiggityDog.Components.NavButton as NavButton
import Section.Two.DiggityDog.Components.PagedImageViewer as PageImageViewer
import Section.Two.DiggityDog.Data.BreedList (breeds, subBreeds)
import Type.Proxy (Proxy(..))

_backButton :: Proxy "backButton"
_backButton = Proxy

_dogBreedsItem :: Proxy "dogBreedsItem"
_dogBreedsItem = Proxy

_imageView :: Proxy "imageView"
_imageView = Proxy

data BackButtonAction = BackClicked

component
  :: forall q i o m
   . LogMessage m
  => GetBreeds m
  => GetBreedDetails m
  => MonadAsk Int m
  => H.Component q i o m
component = Hooks.component \_ _ -> Hooks.do
  Tuple model modelId <- Hooks.useState Nothing
  Tuple currentBreed currentBreedId <- Hooks.useState Nothing

  Hooks.useLifecycleEffect do
    breedsE <- getBreeds
    case breedsE of
      Left err -> do
        logMessage $ "Unable to load breeds due to error: " <> err
        Hooks.put modelId (Just { dogBreeds: Left err, dogBreedImages: Map.empty })
      Right newBreeds -> Hooks.put modelId (Just { dogBreeds: Right newBreeds, dogBreedImages: Map.empty })
    pure Nothing

  let
    handleBreedClick :: BreedItemMessage -> HookM m Unit
    handleBreedClick (BreedClicked breed) = do
      Hooks.put currentBreedId (Just breed)
      for_ model \{ dogBreedImages } -> do
        let breedImagesM = Map.lookup breed dogBreedImages
        case breedImagesM of
          Just _ -> pure unit -- lets not waste an additional query
          Nothing -> do
            breedDetailsE <- getBreedDetails breed
            case breedDetailsE of
              Left err -> do
                logMessage $ "Unable to load breed images due to error: " <> err
                let newImages = Map.insert breed (Left err) dogBreedImages
                Hooks.modify_ modelId (\modelM -> modelM <#> (_ { dogBreedImages = newImages }))
              Right images -> do
                let newImages = Map.insert breed (Right images) dogBreedImages
                Hooks.modify_ modelId (\modelM -> modelM <#> (_ { dogBreedImages = newImages }))

    handleBackClicked :: BackButtonAction -> HookM m Unit
    handleBackClicked BackClicked = Hooks.put currentBreedId Nothing

  Hooks.pure do
    case model of
      Just { dogBreeds, dogBreedImages } ->
        case currentBreed of
          Nothing ->
            case dogBreeds of
              Left err -> HH.p_ [ HH.text $ "Failed to load dog breeds: " <> err ]
              Right dBreeds ->
                HH.div_
                  [ HH.h1_ [ HH.text "Dog Breeds" ]
                  , HH.ol_
                      -- why all this conversion? Array.fromFoldable over a set yields things in
                      -- order, as expected
                      ( mapWithIndex
                          ( \idx breed ->
                              HH.slot _dogBreedsItem idx DogBreedsItem.component
                                { dogBreedPair: Tuple breed (Array.fromFoldable $ subBreeds dBreeds breed) }
                                handleBreedClick
                          )
                          (Array.fromFoldable $ breeds dBreeds)
                      )
                  ]
          Just dogBreed ->
            case Map.lookup dogBreed dogBreedImages of
              Just (Right imgs) ->
                HH.div_
                  [ HH.slot _backButton unit NavButton.component { title: "Back", disabled: false, onClick: BackClicked } handleBackClicked
                  , HH.slot_ _imageView unit PageImageViewer.component { images: imgs }
                  ]
              --    HH.p_ [ HH.text "Successfully loaded images" ]
              Just (Left err) -> HH.p_ [ HH.text $ "Failed to load images: " <> err ]
              Nothing -> HH.p_ [ HH.text "Loading " ]
      Nothing -> HH.p_ [ HH.text "Loading..." ]

