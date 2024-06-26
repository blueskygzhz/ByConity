CREATE TABLE test
(
    `a0` UInt64 DEFAULT a1 + 1,
    `a1` UInt64 DEFAULT a0 + 1,
    `a2` UInt64 DEFAULT a3 + a4,
    `a3` UInt64 DEFAULT a2 + 1,
    `a4` UInt64 ALIAS a3 + 1
)
ENGINE = CnchMergeTree() order by tuple(); -- { serverError 174 }

CREATE TABLE pythagoras
(
    `a` Float64 DEFAULT sqrt((c * c) - (b * b)),
    `b` Float64 DEFAULT sqrt((c * c) - (a * a)),
    `c` Float64 DEFAULT sqrt((a * a) + (b * b))
)
ENGINE = CnchMergeTree() order by tuple(); -- { serverError 174 }

-- TODO: It works but should not: CREATE TABLE test (a DEFAULT b, b DEFAULT a) ENGINE = CnchMergeTree
