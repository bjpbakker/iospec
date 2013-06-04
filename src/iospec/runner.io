Runner := Object clone do (
  init := method(
    newSlot("world")
    newSlot("report")
  )

  run := method(
    report startRun
    world suites foreach(suite,
      suite run
    )
    report dump
  )
)

