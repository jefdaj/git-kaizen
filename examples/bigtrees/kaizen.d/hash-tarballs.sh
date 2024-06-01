#!/usr/bin/env bash

# set -x

cd "$TMPDIR"

# TODO pass config vars so they can be used like this:
INPATH="${GITKAIZEN_REPO_DIR}/${1}"

OUTPATH="$(dirname "$INPATH")/$(basename "$INPATH" | cut -d'.' -f1)".bigtree

case "$GITKAIZEN_RUN_MODE" in
  LIST_OUTPUTS) echo "$OUTPATH"; exit 0;;
  *) echo "error"; exit 1;;
esac

# TODO otherwise, do the extract into tmpdir + bigtrees hash thing
