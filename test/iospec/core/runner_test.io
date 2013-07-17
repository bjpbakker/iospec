passedSpec := Stub clone stub("isPassed", true) stub("isFailed", false)
failedSpec := Stub clone stub("isPassed", false) stub("isFailed", true)

assert("Runner => passes running suites in World",
  world := World clone
  suite := Stub clone stub("run", list(passedSpec))
  world register(suite)
  result := Runner clone setWorld(world) setReport(NullReport) run
  result allPassed == true
)

assert("Runner => fails running suites in World",
  world := World clone
  suite := Stub clone stub("run", list(failedSpec))
  world register(suite)
  result := Runner clone setWorld(world) setReport(NullReport) run
  result allPassed == false
)

assert("Runner => notifies report of start run",
  report := Mock clone
  report shouldReceive("start")
  report ignore("finish")
  Runner clone setWorld(World clone) setReport(report) run
  report verify
)

assert("Runner => notifies report of finish run",
  report := Mock clone
  report ignore("start")
  report shouldReceive("finish")
  Runner clone setWorld(World clone) setReport(report) run
  report verify
)

