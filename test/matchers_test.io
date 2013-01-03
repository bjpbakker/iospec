doRelativeFile("test_helper.io")

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
  try (
    m := OperatorMatcher clone
    m actual := 1
    m matches(message(== 2))
  ) error == "expected: 2\n     got: 1 (using ==)"
)

