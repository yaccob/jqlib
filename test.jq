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
    from_object == [
        [  "",   "a",   "c",  "b"   ],
        [  "A",  1,     2,    null  ],
        [  "B",  null,  4,    3     ],
        [  "C",  5,     7,    6     ]
    ]
)
