MatcherProxy := Object clone do (
  newSlot("matcher")

  on := method(actual, matcher, name,
    proxy := self clone setMatcher(matcher clone setActual(actual))
    proxy setSlot(name, method(
      matcher setExpected(
        parseExpectedArgs(call message arguments, call sender)
      )
      matcher matchForShould or \
          ExpectationNotMetError raise(matcher failureMessageForShould)
    ))
    proxy
  )

  parseExpectedArgs := method(arguments, context,
    args := arguments map(arg, context doMessage(arg))
    if (args size == 0,
      nil,
      if (args size == 1,
        args at(0),
        args))
  )
)
