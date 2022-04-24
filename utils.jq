import "./bank-history" as $BANK_HISTORY;
def all_data: $BANK_HISTORY;

def filter_nulls: map_values(values);
def filter(f): map(select(f));

def description($regex): .description | test($regex; "i");
def debit(filter): .debit | filter;
def credit(filter): .credit | filter;
def gt($amt): . > $amt;
def lt($amt): . < $amt;
def after($timestamp): .timestamp > $timestamp;
def before($timestamp): .timestamp < $timestamp;
def ymd($y;$m;$d): "\($y)-\($m)-\($d)" | strptime("%y-%m-%d") | mktime;

def breakdown_by(predicate; $detailed):
    map(select(predicate))
  | group_by(.description)
  | map(
      {
        description: .[0].description,
        debit: map(.debit) | add,
        credit: map(.credit) | add
      } +
      if $detailed then { detailed: . } else {} end
    | filter_nulls
    )
  | {
      debit: . | map(.debit) | add,
      credit: . | map(.credit) | add,
      breakdown: .,
    }
  | filter_nulls
;

def breakdown_by(predicate): breakdown_by(predicate; false);
