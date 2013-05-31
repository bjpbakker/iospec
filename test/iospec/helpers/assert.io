AssertionError := Exception clone

assert := method(synopsis,
  ex := try (
    result := call target doMessage(call message argAt(1))
    if (result,
      ("[PASS] " .. synopsis) println,
      AssertionError raise)
  )
  if (ex,
    ex setError("[FAIL] " .. synopsis .. ": " .. ex error)
    ex pass
  )
)

