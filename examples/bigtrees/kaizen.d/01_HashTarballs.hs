module HashTarballs where

import GitKaizen.Interface
import Control.Monad (filterM, forM)
import System.Directory (doesFileExist)

kaizen :: Kaizen
kaizen = Kaizen

  -- TODO rename kDescription? name is really the basename without priority number
  { kDescription = "bigtrees hash tarballs"

  -- , kListInputs = [GlobOne "*.tar*"]
  , kListInputs = \mp -> gitAnnexFind mp >>= singletons -- >>= notAllDone listOutputs

  -- This takes one group of input files and returns the corresponding output
  -- files.  If you define it as a named fn below, you can also use it as above
  -- to filter out already-done files from the inputs.
  -- TODO make that an automatic feature of git-kaizen later?
  -- TODO rename kListOutputs:
  -- , kListOutputs = outpaths
  -- , kListOutputs = \_ -> return []

  -- TODO rename kRunScript or similar?
  , kMainScript = \_ -> return () -- TODO write this

  }

gitAnnexFind :: Maybe FilePath -> IO [FilePath]
gitAnnexFind = undefined

-- TODO automatically do this in git-kaizen after calling the script to list outputs:
--
-- remove paths that already have a corresponding .bigtree file
-- TODO move to Interface
-- This should usually be the last thing in the list inputs pipeline,
-- because you want the inputs properly grouped.
-- notAllDone :: ListOutputsFn -> [[FilePath]] -> IO [[FilePath]]
-- notAllDone listOutputsFn inPathLists =
--   flip filterM inPathLists $ \inPaths -> do
--     outPaths <- listOutputsFn inPaths
--     outPathsExist <- mapM doesFileExist outPaths
--     return $ not $ all id outPathsExist

-- TODO is this a standard fn already?
-- TODO if not, move to Interface
singletons :: [FilePath] -> IO [[FilePath]]
singletons = mapM $ \p -> return [p]

-- TODO generalize to "results" and have fields like "added" and "removed"?
--      then this could be called preview
-- listOutputs :: ListOutputsFn
-- listOutputs inpaths = return [dropExtension $ head inpaths]
