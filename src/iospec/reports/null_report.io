NullReport := Object clone do (
  startContext := method(nil)
  endContext := method(nil)

  startRun := method(nil)
  dump := method(nil)

  pass := method(nil)
  pending := method(nil)
  fail := method(nil)
)

