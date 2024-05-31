module GatherTarballs (kaizen) where

import GitKaizen.Interface
import Control.Monad (filterM, forM)
import System.Directory (doesFileExist)

kaizen :: Kaizen
kaizen = Kaizen

  -- TODO rename kDesc? name is really the basename without priority number
  { kDesc = "bigtrees hash tarballs"

  -- , kListInputs = [GlobOne "*.tar*"]
  , kListInputs = \mp -> gitAnnexFind mp >>= notDone

  -- This takes one group of input files and returns the corresponding output files.
  -- If you define it as a named fn below, you can also use it as part of list inputs.
  -- TODO rename kListOutputs:
  -- , kListOutputs = outpaths
  , kListOutputs = \_ -> return []

  -- TODO rename kRunScript or similar?
  , kMainScript = \_ _ -> return () -- TODO write this

  }

gitAnnexFind :: Maybe FilePath -> IO [FilePath]
gitAnnexFind = undefined

-- remove paths that already have a corresponding .bigtree file
-- TODO move to Interface
notDone :: [FilePath] -> IO [FilePath]
-- notDone ps = filterM (\p -> (not . any) <$> doesFileExist $ outpaths p)
notDone ps = filterM undefined ps

-- TODO think this through a bit more, seems forced with the mapping :/

-- TODO move this to Interface?
-- TODO rename to explain that this one takes ONE input path?
outpathsAllExist :: FilePath -> IO Bool
outpathsAllExist p = do
  outs <- outpaths [p]
  outsExist <- mapM doesFileExist outs
  return $ all id outsExist

-- TODO is this a standard fn already?
-- TODO if not, move to Interface
-- TODO IO here, right?
singletons :: [FilePath] -> IO [[FilePath]]
singletons = undefined -- return $ map $ \p -> [p]

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
outpaths :: [FilePath] -> IO [FilePath]
outpaths inpaths = return [dropExtension $ head inpaths]
