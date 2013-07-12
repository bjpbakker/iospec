Object should := method(
  if (call message next == nil,
    InappropriateUseOfDSL raise("No matcher provided to should"))
  matcherName := call message next name
  matcher := MatcherRegister get(matcherName)
  MatcherProxy on(self, matcher, matcherName)
)

InappropriateUseOfDSL := Exception clone
