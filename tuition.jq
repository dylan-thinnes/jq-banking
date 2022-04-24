#!/usr/bin/env -S jq -nf
include "utils";

all_data
  | filter(debit(gt(5000)) and description("univ|uoe"))
  | sort_by(.timestamp)
  | .[]
  | { description, debit, date }
