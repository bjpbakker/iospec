Runner := Object clone do (
  newSlot("world")
  newSlot("report")

  run := method(
    report start
    world suites foreach(suite,
      suite run
    )
    report startDump
  )
)

