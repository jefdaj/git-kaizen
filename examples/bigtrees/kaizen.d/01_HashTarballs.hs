module GatherTarballs (kaizen) where

import GitKaizen.Interface
import Control.Monad (filterM, forM)
import System.Directory (doesFileExist)

kaizen :: Kaizen
kaizen = Kaizen

  -- TODO rename kDescription? name is really the basename without priority number
  { kDescription = "bigtrees hash tarballs"

  -- , kListInputs = [GlobOne "*.tar*"]
  , kListInputs = \mp -> gitAnnexFind mp >>= notDone outpaths

  -- This takes one group of input files and returns the corresponding output files.
  -- If you define it as a named fn below, you can also use it as part of list inputs.
  -- TODO rename kListOutputs:
  -- , kListOutputs = outpaths
  , kListOutputs = \_ -> return []

  -- TODO rename kRunScript or similar?
  , kMainScript = \_ -> return () -- TODO write this

  }

gitAnnexFind :: Maybe FilePath -> IO [[FilePath]]
gitAnnexFind = undefined

-- remove paths that already have a corresponding .bigtree file
-- TODO move to Interface
-- This should usually be the last thing in the list inputs pipeline,
-- because you want the inputs properly grouped.
notDone :: ListOutputsFn -> [[FilePath]] -> IO [[FilePath]]
-- notDone ps = filterM (\p -> (not . any) <$> doesFileExist $ outpaths p)
notDone listOutputsFn inPathLists = flip filterM inPathLists $ \ps -> do
  outPaths      <- listOutputsFn ps
  outPathsExist <- mapM doesFileExist outPaths
  return $ not $ all id outPathsExist

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
outpaths :: ListOutputsFn
outpaths inpaths = return [dropExtension $ head inpaths]
