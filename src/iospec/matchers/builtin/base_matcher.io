BaseMatcher := Object clone do (
  newSlot("expected")
  newSlot("actual")

  register := method(name, optionalMatcher,
    matcher := if(optionalMatcher != nil, optionalMatcher, self)
    MatcherRegister put(name, matcher)
  )
)
