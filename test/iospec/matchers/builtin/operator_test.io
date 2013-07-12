assert("Operator#matchForShould => match with equals operator",
  matcher := Operator clone setOperator("==") setExpected(12) setActual(12)
  matcher matchForShould
)

assert("Operator#matchForShould => differ with equals operator",
  matcher := Operator clone setOperator("==") setExpected(12) setActual(14)
  matcher matchForShould == false
)

assert("Operator#matchForShould => match with less-than operator",
  matcher := Operator clone setOperator("<") setExpected(10) setActual(9)
  matcher matchForShould
)

assert("Operator#matchForShouldNot => match with equals operator",
  matcher := Operator clone setOperator("==") setExpected(10) setActual(15)
  matcher matchForShouldNot
)

assert("Operator#matchForShouldNot => differ with greater-than operator",
  matcher := Operator clone setOperator(">") setExpected(10) setActual(15)
  matcher matchForShouldNot == false
)

assert("Operator#failureMessageForShould => get failure message",
  matcher := Operator clone setOperator("==") setExpected(15) setActual(10)
  matcher failureMessageForShould == "expected: 15\n     got: 10\n\n(compared using ==)\n"
)

assert("Operator#failureMessageForShouldNot => get failure message",
  matcher := Operator clone setOperator("==") setExpected(15) setActual(10)
  matcher failureMessageForShouldNot == "expected: not 15\n     got: 10\n\n(compared using ==)\n"
)
