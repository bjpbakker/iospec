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
    ctx := ErrorContext clone setOperator(matcher name)
    ctx setExpected(matcher arguments join(" ")) setActual(actual)
    "expected: #{expected}\n     got: #{actual} (using #{operator})" interpolate(ctx)
  )

  ErrorContext := Object clone do (
    newSlot("operator")
    newSlot("expected")
    newSlot("actual")
  )
)

