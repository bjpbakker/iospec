passedSpec := Stub clone stub("isPassed", true) stub("isFailed", false) stub("isPending", false)
failedSpec := Stub clone stub("isPassed", false) stub("isFailed", true) stub("isPending", false)

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

assert("Runner => notifies report of a starting a context",
  report := Mock clone ignore("start", "finish", "endContext")
  report shouldReceive("startContext")
  suite := Stub clone stub("run", list(passedSpec))
  Runner clone setWorld(World clone register(suite)) setReport(report) run
  report verify
)

assert("Runner => notifies report of passed spec",
  report := Mock clone ignore("start", "finish", "startContext", "endContext")
  report shouldReceive("pass")
  suite := Suite clone append(Spec with("name", block(nil)))
  Runner clone setWorld(World clone register(suite)) setReport(report) run
  report verify
)

assert("Runner => notifies report of failed spec",
  report := Mock clone ignore("start", "finish", "startContext", "endContext")
  report shouldReceive("fail")
  suite := Suite clone append(Spec with("name", block(Exception clone raise)))
  Runner clone setWorld(World clone register(suite)) setReport(report) run
  report verify
)

assert("Runner => notifies report of pending spec",
  report := Mock clone ignore("start", "finish", "startContext", "endContext")
  report shouldReceive("pending")
  suite := Suite clone append(Spec with("name", block(pending)))
  Runner clone setWorld(World clone register(suite)) setReport(report) run
  report verify
)

assert("Runner => notifies report of finished context",
  report := Mock clone ignore("start", "finish", "startContext")
  report shouldReceive("endContext")
  suite := Stub clone stub("run", list(passedSpec))
  Runner clone setWorld(World clone register(suite)) setReport(report) run
  report verify
)

assert("Runner => notifies report of finish run",
  report := Mock clone
  report ignore("start")
  report shouldReceive("finish")
  Runner clone setWorld(World clone) setReport(report) run
  report verify
)

