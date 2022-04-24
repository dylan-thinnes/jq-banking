#!/usr/bin/env -S jq -nf
include "utils";

all_data
  | filter(description("pow") and after(ymd(20;9;1)))
  | sort_by(.timestamp)
  | map({ date, debit })
  | {
      total: map(.debit) | add,
      data: .
    }
