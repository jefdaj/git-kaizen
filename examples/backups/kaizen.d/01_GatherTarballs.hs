module GatherTarballs (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen
  { kDescription = "gather tarballs"
  , kListInputs  = \_ ps -> findTarballs ps >>= return . singleton -- [GlobOne "*.tar*"]
  -- , kListOutputs = toOutdirNoClobber "tarballs" -- TODO repo variable here?
  , kMainScript  = "gather-tarballs.sh"
  }

-- TODO is this simpler than a lambda? (maybe better for interface at least)
singleton :: a -> [a]
singleton x = [x]

findTarballs :: [FilePath] -> IO [FilePath]
findTarballs = undefined

removeAlreadyInOutdir :: [FilePath] -> IO [FilePath]
removeAlreadyInOutdir = undefined

-- Move all files to the output directory, renaming as necessary to avoid
-- clobbering existing files.
-- toOutdirNoClobber :: FilePath -> [FilePath] -> IO [FilePath]
-- toOutdirNoClobber outDir inTarballs = undefined
