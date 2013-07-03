ExpectationNotMetError := Exception clone

OperatorMatcher := Object clone do (
  newSlot("actual")

  matches := method(matcher,
    resultOfMsg := actual doMessage(matcher)
    if (resultOfMsg,
      true,
      failWithMessage(formatError(matcher))
    )
  )

  failWithMessage := method(message,
    ExpectationNotMetError raise(message)
  )

  formatError := method(matcher,
    expected := matcher arguments map(arg, describeArgument(arg)) join(" ")
    ctx := ErrorContext clone setOperator(matcher name)
    ctx setExpected(expected asString asMutable escape) setActual(actual asString asMutable escape)
    "expected: #{expected}\n     got: #{actual} (using #{operator})" interpolate(ctx)
  )

  describeArgument := method(argument,
      if (argument hasCachedResult,
          argument cachedResult,
          argument code)
  )

  ErrorContext := Object clone do (
    newSlot("operator")
    newSlot("expected")
    newSlot("actual")
  )
)
