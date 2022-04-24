#!/usr/bin/env -S jq -nf
include "utils";

def companies:
  [
    { name: "Sainsburys", grep: "sains" },
    { name: "Lidl", grep: "lidl" },
    { name: "Tesco", grep: "tesco" },
    { name: "Touch of Poland", grep: "touch of poland" }
  ];

companies | map(. as $company |
  all_data
    | filter(description($company.grep))
    | {
        name: $company.name,
        total: map(.debit) | add
      }
)
