module GatherTarballs (kaizen) where

import GitKaizen.Interface

kaizen :: Kaizen
kaizen = Kaizen

  -- TODO rename kDesc? name is really the basename without priority number
  { kDesc = "bigtrees hash tarballs"

  -- , kListInputs = [GlobOne "*.tar*"]
  , kListInputs = gitAnnexFind >>= notDone

  -- This takes one group of input files and returns the corresponding output files.
  -- If you define it as a named fn below, you can also use it as part of list inputs.
  -- TODO rename kListOutputs:
  , kListOutputs = outpaths

  -- TODO rename kRunScript or similar?
  , kMainScript = undefined -- TODO write this

  }

gitAnnexFind :: IO [FilePath]
gitAnnexFind = undefined

-- remove paths that already have a corresponding .bigtree file
-- TODO move to Interface
notDone :: [FilePath] -> IO [FilePath]
notDone = filter <$> \p -> outpaths p >>= undefined -- TODO finish

-- TODO is this a standard fn already?
-- TODO if not, move to Interface
-- TODO IO here, right?
singletons :: [FilePath] -> IO [[FilePath]]
singletons = return $ map $ \p -> [p]

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
outpaths :: [String] -> [String]
outpaths inpaths = [dropExtension $ head inpaths]
