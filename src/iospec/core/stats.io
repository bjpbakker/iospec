Stats := Object clone do (
  newSlot("passed", 0)
  newSlot("failed", 0)
  newSlot("pending", 0)

  inc := method(
    what := call argAt(0) name
    current := self getSlot(what)
    self setSlot(what, current + 1)
    self
  )

  total := method(
    passed + failed + pending
  )

  allPassed := method(
    failed == 0
  )
)
