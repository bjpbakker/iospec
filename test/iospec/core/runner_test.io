module(iospec) do (
  module(core) do (
    ignoreReport := iospec doubles Mock clone ignore(start, finish, startContext, endContext, pass, fail, pending)
    passingSpec := Spec with("passing", block(nil))
    failingSpec := Spec with("failing", block(Exception raise))

    assert("Runner => passes running suites in World",
      world := World clone
      suite := Suite clone append(passingSpec)
      world register(suite)
      result := Runner clone setWorld(world) setReport(ignoreReport) run
      result allPassed == true
    )

    assert("Runner => fails running suites in World",
      suite := Suite clone append(failingSpec)
      world := World clone register(suite)
      result := Runner clone setWorld(world) setReport(ignoreReport) run
      result allPassed == false
    )

    assert("Runner => notifies report of start run",
      report := iospec doubles Mock clone
      report shouldReceive(start)
      report ignore(finish)
      Runner clone setWorld(World clone) setReport(report) run
      report verify
    )

    assert("Runner => notifies report of a starting a context",
      report := iospec doubles Mock clone ignore(start, finish, endContext, pass)
      report shouldReceive(startContext)
      suite := Suite clone append(passingSpec)
      Runner clone setWorld(World clone register(suite)) setReport(report) run
      report verify
    )

    assert("Runner => notifies report of passed spec",
      report := iospec doubles Mock clone ignore(start, finish, startContext, endContext)
      report shouldReceive(pass)
      suite := Suite clone append(Spec with("name", block(nil)))
      Runner clone setWorld(World clone register(suite)) setReport(report) run
      report verify
    )

    assert("Runner => notifies report of failed spec",
      report := iospec doubles Mock clone ignore(start, finish, startContext, endContext)
      report shouldReceive(fail)
      suite := Suite clone append(Spec with("name", block(Exception clone raise)))
      Runner clone setWorld(World clone register(suite)) setReport(report) run
      report verify
    )

    assert("Runner => notifies report of pending spec",
      report := iospec doubles Mock clone ignore(start, finish, startContext, endContext)
      report shouldReceive(pending)
      suite := Suite clone append(Spec with("name", block(pending)))
      Runner clone setWorld(World clone register(suite)) setReport(report) run
      report verify
    )

    assert("Runner => notifies report of finished context",
      report := iospec doubles Mock clone ignore(start, finish, startContext, pass)
      report shouldReceive(endContext)
      suite := Suite clone append(passingSpec)
      Runner clone setWorld(World clone register(suite)) setReport(report) run
      report verify
    )

    assert("Runner => notifies report of finish run",
      report := iospec doubles Mock clone
      report ignore(start)
      report shouldReceive(finish)
      Runner clone setWorld(World clone) setReport(report) run
      report verify
    )

    assert("Runner => collects passed stats",
      suite := Suite clone append(Spec with("passing", block(nil)))
      runner := Runner clone setWorld(World clone register(suite)) setReport(ignoreReport)
      runner run
      runner stats passed == 1
    )

    assert("Runner => collects failed stats",
      suite := Suite clone append(Spec with("failing", block(Exception raise)))
      runner := Runner clone setWorld(World clone register(suite)) setReport(ignoreReport)
      runner run
      runner stats failed == 1
    )

    assert("Runner => collects pending stats",
      suite := Suite clone append(Spec with("pending", block(pending)))
      runner := Runner clone setWorld(World clone register(suite)) setReport(ignoreReport)
      runner run
      runner stats pending == 1
    )
  )
)
