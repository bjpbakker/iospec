Runner := Object clone do (
  init := method(
    newSlot("world")
    newSlot("report")
  )

  run := method(
    report start
    executor := SuiteExecutor with(report)
    world suites foreach(suite,
      executor execute(suite)
    )
    report finish
    return RunResults clone setAllPassed(
      executor results select(isFailed) isEmpty
    )
  )
)

SuiteExecutor := Object clone do (
  with := method(report,
    executor := self clone
    executor report := report
    executor results := list
    executor
  )

  execute := method(suite,
    report startContext(suite subject)
    results appendSeq(suite run(self))
    report endContext(suite subject)
  )

  onSpecExecuted := method(name, result,
    if (result isPassed) then (
      report pass(name)
    ) else (if (result isFailed) then (
      report fail(name, result cause)
    ) else (if (result isPending) then (
      report pending(name)
    )))
  )

  call := getSlot("onSpecExecuted")
)

RunResults := Object clone do (
  newSlot("allPassed")
)
