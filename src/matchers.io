ExpectationNotMetError := Exception clone

OperatorMatcher := Object clone
OperatorMatcher matches := method(operator_msg,
  result_of_msg := actual doMessage(operator_msg)
  if (result_of_msg,
    true,
    fail_with_message(format_error(operator_msg))
  )
)
OperatorMatcher fail_with_message := method(message,
  ExpectationNotMetError raise(message)
)
OperatorMatcher format_error := method(operator_msg,
  operator := operator_msg name
  expected := operator_msg arguments join (" ")
  "expected: " .. expected .. "\n     got: " .. actual .. " (using " .. operator .. ")"
)

