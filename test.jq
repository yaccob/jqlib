include "tables";

{
    "A": {
        "a": 1,
        "c": 2
    },
    "B": {
        "b": 3,
        "c": 4
    },
    "C": {
        "a": 5,
        "b": 6,
        "c": 7
    }
} as $testobject

| $testobject | (
    from_object | select(. != [
        [  "",   "a",   "c",  "b"   ],
        [  "A",  1,     2,    null  ],
        [  "B",  null,  4,    3     ],
        [  "C",  5,     7,    6     ]
    ]) // "success"
), (
    from_object | to_adoc | select(
        . != "[cols=\"1h,1,1,1\"]\n"
        + "|===\n"
        + "|  | a | c | b\n"
        + "\n"
        + "| A | 1 | 2 | \n"
        + "| B |  | 4 | 3\n"
        + "| C | 5 | 7 | 6\n"
        + "|==="
    ) // "success"
)
