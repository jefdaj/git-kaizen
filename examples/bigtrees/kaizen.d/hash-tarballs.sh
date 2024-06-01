#!/usr/bin/env bash

set -x

cd "$TMPDIR"

INPATH="$1"
OUTPATH="$(dirname "$INPATH")/$(basename "$INPATH" | cut -d'.' -f1)".bigtree

# TODO can i define it in a way that shortens this?
if [[ $GITKAIZEN_RUN_MODE == LIST_OUTPUTS ]]; then
  echo "$OUTPATH"
  exit 0
fi

# TODO otherwise, do the extract into tmpdir + bigtrees hash thing
