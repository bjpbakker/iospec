Runner := Object clone do (
  newSlot("files")

  run := method(
    files foreach(file, Lobby doFile(file))
  )
)

