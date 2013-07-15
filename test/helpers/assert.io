TestStats := Object clone do (
  inc := method(what,
    self setSlot(what, self getSlot(what) + 1)
  )

  reset := method(
    self setSlot("pass", 0)
    self setSlot("pending", 0)
    self setSlot("fail", 0)
    self setSlot("error", 0)
  )
)
TestStats clone := TestStats

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
      onError(synopsis, ex, printer),
      if (result == "*PENDING*",
        onPending(synopsis, printer),
        if (result,
          onPass(synopsis, printer), 
          onFail(synopsis, result, printer)
        )
      )
    )
  )

  onPass := method(synopsis, printer,
    TestStats inc("pass")
    printer onPass(synopsis)
  )

  onPending := method(synopsis, printer,
    TestStats inc("pending")
    printer onPending(synopsis)
  )

  onFail := method(synopsis, result, printer,
    TestStats inc("fail")
    printer onFail(synopsis)
  )

  onError := method(synopsis, error, printer,
    TestStats inc("error")
    printer onError(synopsis, error)
  )
)

ResultPrinter := Colorizer clone do (
  onPass := method(synopsis,
    (green("[PASS] ") .. synopsis) println
  )
  onFail := method(synopsis, result,
    (red("[FAIL] ") .. synopsis .. " (got: " .. result .. ")") println
  )
  onPending := method(synopsis,
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
