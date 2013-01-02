AssertionError ::= Exception clone

assert := method(synopsis,
  result := call target doMessage(call message argAt(1))
  if (result, ("[PASS] " .. synopsis) println,
    AssertionError raise("[FAIL] " .. synopsis))
)

