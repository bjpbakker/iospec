assert("MatcherProxy => get object with named function",
  proxy := MatcherProxy on(5, Equal, "equal")
  proxy slotNames contains("equal")
)

assert("MatcherProxy => get true if target matches expected",
  proxy := MatcherProxy on(5, Equal, "equal")
  proxy equal(5) == true
)

assert("MatcherProxy => throws if target differs expected",
  proxy := MatcherProxy on(5, Equal, "equal")
  ex := try ( proxy equal(10) )
  ex isKindOf(ExpectationNotMetError)
)

assert("MatcherProxy => exception has message",
  proxy := MatcherProxy on(5, Equal, "equal")
  ex := try ( proxy equal(7) )
  ex error
)

assert("MatcherProxy => evaluates arguments in context of sender",
  expected := "<value>"
  proxy := MatcherProxy on("<value>", Equal, "equal")
  proxy equal(expected)
)

assert("MatcherProxy => passes list of expectations as multiple arguments given",
  proxy := MatcherProxy on(list(1,2,3), Equal, "equal")
  proxy equal(1,2,3)
)

assert("MatcherProxy => passes nil as no arguments given",
  proxy := MatcherProxy on(nil, Equal, "equal")
  proxy equal
)

assert("MatcherProxy => supports multiple matches",
  proxy := MatcherProxy on(5, Equal, "equal")
  proxy equal(5)
  proxy equal(5)
)
