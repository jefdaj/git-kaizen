module Util where

import Colog.Core (LogAction(..))
import Control.Monad.IO.Class (MonadIO)

-- | For disabling logs during unit tests.
-- TODO redirect them somewhere for inspection instead
logNowhere :: MonadIO m => LogAction m String
logNowhere = LogAction $ \_ -> return ()
