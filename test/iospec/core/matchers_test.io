doRelativeFile("../test_helper.io")

assert("OperatorMatcher => matches use == operator",
  m := OperatorMatcher clone
  m actual := "text"
  m matches(message(== "text"))
)

assert("OperatorMatcher => matches use < operator",
  m := OperatorMatcher clone
  m actual := 10
  m matches(message(< 11))
)

assert("OperatorMatcher => reports error as expectation not met",
  cause := try (
    OperatorMatcher clone setActual(1) matches(message(== 2))
  )
  if (cause isKindOf(ExpectationNotMetError),
    cause error == "expected: 2\n     got: 1 (using ==)",
    cause pass)
)

assert("OperatorMatcher => reports cached result of expectation",
  cause := try (
    cachedMsg := message(== "two") asMessageWithEvaluatedArgs
    OperatorMatcher clone setActual("one") matches(cachedMsg)
  )
  if (cause isKindOf(ExpectationNotMetError),
    cause error == "expected: two\n     got: one (using ==)",
    cause pass)
)

assert("OperatorMatcher => reports values as escaped sequences",
  escape := method(s,
    s asMutable escape
  )
  cause := try (
    OperatorMatcher clone setActual("one\ntwo") matches(message(== "one\ntwo\n"))
  )
  if (cause isKindOf(ExpectationNotMetError),
    cause error == ("expected: " .. escape("one\ntwo\n") .. "\n     got: " .. escape("one\ntwo") .. " (using ==)"),
    cause pass)
)
