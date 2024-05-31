module GatherTarballs (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kDesc = "gather tarballs"
  , kListInputs = findTarballs -- [GlobOne "*.tar*"]
  , kListOutputs = gatherInOutdir "tarballs" -- TODO repo variable here?
  , kMainScript = undefined -- TODO write this
  }

findTarballs :: Maybe FilePath -> IO [FilePath]
findTarballs = undefined

removeAlreadyInOutdir :: [FilePath] -> [FilePath]
removeAlreadyInOutdir = undefined

-- Move all files to the output directory, renaming as necessary to avoid
-- clobbering existing files.
gatherInOutdir :: FilePath -> [FilePath] -> [FilePath]
gatherInOutdir outDir inTarballs = undefined
