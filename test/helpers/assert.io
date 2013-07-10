Test := Object clone do (
  newSlot("synopsis")
  newSlot("target")
  newSlot("testMessage")

  create := method(synopsis, target, testMessage,
    Test clone setSynopsis(synopsis) setTarget(target) setTestMessage(testMessage)
  )

  run := method(printer,
    ex := try (
      result := block(target doMessage(testMessage)) call
    )
    if (ex,
      printer onError(synopsis, ex),
      if (result == "*PENDING*",
        printer onPending call(synopsis),
        if (result,
          printer onPass call(synopsis),
          printer onFail call(synopsis, result)
        )
      )
    )
  )
)

ResultPrinter := Colorizer clone do (
  onPass := block(synopsis,
    (green("[PASS] ") .. synopsis) println
  )
  onFail := block(synopsis, result,
    (red("[FAIL] ") .. synopsis .. " (got: " .. result .. ")") println
  )
  onPending := block(synopsis,
    (yellow("[PENDING] ") .. synopsis) println
  )
  onError := method(synopsis, ex,
    (red("[ERROR] ") .. synopsis .. " (" .. ex type .. ": " .. ex error .. ")") println
  )
)

assert := method(synopsis,
  test := Test create(synopsis, call target, call message argAt(1))
  test run(ResultPrinter)
)
