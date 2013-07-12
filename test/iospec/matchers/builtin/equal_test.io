assert("Equal#matchForShould => match equal objects",
  matcher := Equal clone setExpected(5) setActual(5)
  matcher matchForShould
)

assert("Equal#matchForShould => differ non-equal objets",
  matcher := Equal clone setExpected(7) setActual(5)
  matcher matchForShould == false
)

assert("Equal#matchForShouldNot => match non-equal objects",
  matcher := Equal clone setExpected(7) setActual(5)
  matcher matchForShouldNot
)

assert("Equal#matchForShouldNot => differ equal objects",
  matcher := Equal clone setExpected(5) setActual(5)
  matcher matchForShouldNot == false
)

assert("Equal#failureMessageForShould => get failure message",
  matcher := Equal clone setExpected(3) setActual(5)
  matcher failureMessageForShould == "expected: 3\n     got: 5\n\n(compared using ==)\n"
)

assert("Equal#failureMessageForShouldNot => get failure message",
  matcher := Equal clone setExpected(3) setActual(5)
  matcher failureMessageForShouldNot == "expected: not 3\n     got: 5\n\n(compared using ==)\n"
)

assert("Equal => registers 'equal' matcher",
  MatcherRegister get("equal") == Equal
)
