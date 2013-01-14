NullReport := Object clone do (
  startContext := method(nil)
  endContext := method(nil)

  start := method(nil)
  startDump := method(nil)

  pass := method(nil)
  pending := method(nil)
  fail := method(nil)
)

