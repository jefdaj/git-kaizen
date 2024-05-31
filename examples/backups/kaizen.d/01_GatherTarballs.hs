module GatherTarballs (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kDescription = "gather tarballs"
  , kListInputs  = findTarballs -- [GlobOne "*.tar*"]
  , kListOutputs = toOutdirNoClobber "tarballs" -- TODO repo variable here?
  , kMainScript  = \_ -> return () -- TODO write this
  }

findTarballs :: Maybe FilePath -> IO [[FilePath]]
findTarballs = undefined

removeAlreadyInOutdir :: [FilePath] -> IO [FilePath]
removeAlreadyInOutdir = undefined

-- Move all files to the output directory, renaming as necessary to avoid
-- clobbering existing files.
toOutdirNoClobber :: FilePath -> [FilePath] -> IO [FilePath]
toOutdirNoClobber outDir inTarballs = undefined
