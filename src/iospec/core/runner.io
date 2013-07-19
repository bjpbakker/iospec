Runner := Object clone do (
  init := method(
    newSlot("world")
    newSlot("report")
    newSlot("stats", Stats clone)
  )

  run := method(
    report start
    executor := SuiteExecutor with(report, stats)
    world suites foreach(suite,
      executor execute(suite)
    )
    report finish(stats)
    stats
  )
)

SuiteExecutor := Object clone do (
  with := method(report, stats,
    executor := self clone
    executor report := report
    executor stats := stats
    executor
  )

  execute := method(suite,
    report startContext(suite subject)
    suite run(self)
    report endContext(suite subject)
  )

  onSpecExecuted := method(name, result,
    if (result isPassed) then (
      onPass(name)
    ) else (if (result isFailed) then (
      onFail(name, result cause)
    ) else (if (result isPending) then (
      onPending(name)
    )))
  )

  onPass := method(name,
    stats inc(passed)
    report pass(name)
  )

  onFail := method(name, error,
    stats inc(failed)
    report fail(name, error)
  )

  onPending := method(name,
    stats inc(pending)
    report pending(name)
  )

  call := getSlot("onSpecExecuted")
)
