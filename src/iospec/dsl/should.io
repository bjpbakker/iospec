Object should := method(
  iospec dsl PositiveShould clone initProxy(call message next, self)
)

Object shouldNot := method(
  iospec dsl NegativeShould clone initProxy(call message next, self)
)

module(iospec) do (
  module(dsl) do (
    Should := Object clone do (
      newSlot("matcher")

      initProxy := method(matcherMsg, actual,
        if (matcherMsg == nil,
          InappropriateUseOfDSL raise("No matcher provided to should"))

        matcherName := matcherMsg name
        self matcher := iospec matchers MatcherRegister get(matcherName) clone setActual(actual)

        iospec matchers MatcherProxy proxy(matcherName, self)
      )

      call := method(expected,
        matcher setExpected(expected)
        doMatch or iospec matchers ExpectationNotMetError raise(failureMessage)
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
  )
)
