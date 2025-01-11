module Section.Two.DiggityDog.Components.NavButton
  ( Props
  , component
  )
  where

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.Hooks as Hooks

type Props a =
  { title :: String
  , disabled :: Boolean
  , onClick :: a
  }

component :: forall q m a. H.Component q (Props a) a m
component = Hooks.component \{ outputToken } { title, disabled, onClick } -> Hooks.do
  Hooks.pure do
    HH.button
      [ HE.onClick \_ -> Hooks.raise outputToken onClick
      , HP.disabled disabled
      ]
      [ HH.text title
      ]