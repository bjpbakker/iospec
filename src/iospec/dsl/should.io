Object should := method(
  PositiveShould clone initProxy(call message next, self)
)

Object shouldNot := method(
  NegativeShould clone initProxy(call message next, self)
)

Should := Object clone do (
  newSlot("matcher")

  initProxy := method(matcherMsg, actual,
    if (matcherMsg == nil,
      InappropriateUseOfDSL raise("No matcher provided to should"))

    matcherName := matcherMsg name
    self matcher := MatcherRegister get(matcherName) clone setActual(actual)

    MatcherProxy proxy(matcherName, self)
  )

  call := method(expected,
    matcher setExpected(expected)
    doMatch or ExpectationNotMetError raise(failureMessage)
  )
)

PositiveShould := Should clone do (
  doMatch := method( matcher matchForShould )
  failureMessage := method( matcher failureMessageForShould )
)

NegativeShould := Should clone do (
  doMatch := method( matcher matchForShouldNot )
  failureMessage := method( matcher failureMessageForShouldNot )
)

InappropriateUseOfDSL := Exception clone
