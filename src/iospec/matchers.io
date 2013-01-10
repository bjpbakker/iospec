ExpectationNotMetError := Exception clone

OperatorMatcher := Object clone do (
  newSlot("actual")

  matches := method(matcher,
    result_of_msg := actual doMessage(matcher)
    if (result_of_msg,
      true,
      fail_with_message(format_error(matcher))
    )
  )

  fail_with_message := method(message,
    ExpectationNotMetError raise(message)
  )

  format_error := method(matcher,
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

