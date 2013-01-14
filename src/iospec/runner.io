Runner := Object clone do (
  newSlot("files")
  newSlot("report")

  run := method(
    report start
    files foreach(file, Lobby doFile(file))
    report startDump
  )
)

