module Section.Two.DiggityDog.Capability.LogMessage where

import Prelude

import Control.Monad.Trans.Class (lift)
import Halogen.Hooks (HookM)

class Monad m <= LogMessage m where
  logMessage :: String -> m Unit

instance LogMessage m => LogMessage (HookM m) where
  logMessage = lift <<< logMessage
