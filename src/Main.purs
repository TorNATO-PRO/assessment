module Main where

import Prelude

import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Section.Two.DiggityDog.App as App
import Section.Two.DiggityDog.AppM (runAppM)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  let app = H.hoist runAppM App.component
  runUI app unit body
