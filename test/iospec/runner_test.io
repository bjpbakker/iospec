doRelativeFile("test_helper.io")

assert("Runner => runs suites from World",
  world := World clone
  suite := Mock clone
  world register(suite)
  Runner clone setWorld(world) setReport(NullReport) run
  suite hasReceived("run")
)

assert("Runner => notifies report of starting run",
  report := Mock clone
  Runner clone setWorld(World clone) setReport(report) run
  report hasReceived("startRun")
)

assert("Runner => dumps report",
  report := Mock clone
  Runner clone setWorld(World clone) setReport(report) run
  report hasReceived("dump")
)

