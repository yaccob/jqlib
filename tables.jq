def field_union:
    # the much simpler approach of using unique was discarded because it changes the order by sorting keys alphabetically
    (map(keys_unsorted) | add | map({key: ., value: null}) | from_entries | keys_unsorted)
;

def for_fields($fields):
    . as $object
    | $fields | map($object[.])
;

def from_object_01:
    keys_unsorted as $rows
    | field_union as $cols
    | to_entries | map([""] + $cols, [.key] + (.value | for_fields($cols)))
;

def from_object:
    keys_unsorted as $rows
    | field_union as $cols
    | [[""] + $cols] + (to_entries | map([.key] + (.value | for_fields($cols))))
;

def to_adoc:
    "[cols=\"1h,\(.[1:] | (map("1") | join(",")))\"]\n"
    + "|===\n"
    + "| " + (.[0] | join(" | "))
    + "\n\n"
    + (["| " + (.[1:][] | join(" | "))] | join("\n"))
    + "\n"
    + "|==="
;

