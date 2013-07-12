Operator := BaseMatcher clone do (
  newSlot("operator")

  matchForShould := method(
    matcher := actual clone
    matcher newSlot("__expected__", expected)
    args := list(message(__expected__))
    matcher doMessage(Message fromString(operator) setArguments(args))
  )

  matchForShouldNot := method(
    matchForShould not
  )

  failureMessageForShould := method (
    msg := "expected: #{expected}\n     got: #{actual}\n\n(compared using #{operator})\n"
    msg interpolate(self)
  )

  failureMessageForShouldNot := method (
    msg := "expected: not #{expected}\n     got: #{actual}\n\n(compared using #{operator})\n"
    msg interpolate(self)
  )
)
