#!/usr/bin/env bash

INPATH="$1"
OUTPATH="$(dirname "$INPATH")/$(basename "$INPATH" | cut -d'.' -f1)"

# TODO can i define it in a way that shortens this?
if [[ $GITKAIZEN_SCRIPT_MODE == LIST_OUTPUTS ]]; then
  echo "$OUTPATH"
  exit 0
fi

# TODO otherwise, do the extract into tmpdir + bigtrees hash thing
