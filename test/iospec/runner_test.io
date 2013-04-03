doRelativeFile("test_helper.io")

assert("Runner => runs suites from World",
  world := World clone
  suite := Mock clone
  world register(suite)
  Runner clone setWorld(world) setReport(NullReport) run
  suite hasReceived("run")
)

assert("Runner => sends 'start' to report",
  report := Mock clone
  Runner clone setWorld(World clone) setReport(report) run
  report hasReceived("start")
)

assert("Runner => starts dump report",
  report := Mock clone
  Runner clone setWorld(World clone) setReport(report) run
  report hasReceived("startDump")
)

