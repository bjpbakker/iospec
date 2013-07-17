Runner := Object clone do (
  init := method(
    newSlot("world")
    newSlot("report")
  )

  run := method(
    report start
    specResults := world suites map(run)
    report finish
    return RunResults clone setAllPassed(
      specResults flatten select(isFailed) isEmpty
    )
  )
)

RunResults := Object clone do (
  newSlot("allPassed")
)
