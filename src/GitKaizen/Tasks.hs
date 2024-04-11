module GitKaizen.Tasks where

import GitKaizen.Types (Task)
import qualified GitKaizen.Tasks.Untar as Untar

tasks :: [Task]
tasks =
  [ Untar.task
  ]
