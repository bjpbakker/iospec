assert("MatcherRegister => contains matchers for operators",
  matcher := Object clone
  MatcherRegister put("operator", matcher)
  registered := MatcherRegister get("operator")
  registered == matcher
)

assert("MatcherRegister => defaults to match on passed operator",
  equalsMatcher := MatcherRegister get("==")
  equalsMatcher isKindOf(Operator) and equalsMatcher operator == "=="
)
