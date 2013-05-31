Runner := Object clone do (
  init := method(
    newSlot("world")
    newSlot("report")
  )

  run := method(
    report startRun
    specResults := world suites map(run)
    report dump
    return RunResults clone setAllPassed(
      specResults flatten select(result, result isFailed) isEmpty
    )
  )
)

RunResults := Object clone do (
  newSlot("allPassed")
)
