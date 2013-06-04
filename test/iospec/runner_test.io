doRelativeFile("test_helper.io")

assert("Runner => runs suites from World",
  world := World clone
  suite := Mock clone
  suite shouldReceive("run")
  world register(suite)
  Runner clone setWorld(world) setReport(NullReport) run
  suite verify
)

assert("Runner => notifies report of starting run",
  report := Mock clone
  report shouldReceive("startRun")
  report ignore("dump")
  Runner clone setWorld(World clone) setReport(report) run
  report verify
)

assert("Runner => dumps report",
  report := Mock clone
  report ignore("startRun")
  report shouldReceive("dump")
  Runner clone setWorld(World clone) setReport(report) run
  report verify
)

