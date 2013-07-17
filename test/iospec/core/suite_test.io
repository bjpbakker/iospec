DummySpec := Spec with("dummy"m block(nil))

Tracker := Object clone do (
  count ::= 0
  inc ::= method(self count := self count + 1)
)

assert("Suite => runs a spec",
  tracker := Tracker clone
  Suite clone setSubject("suite") append(
    Spec with("run this spec", block(tracker inc))
  ) run
  tracker count == 1
)

assert("Suite => passes subject to spec run",
  subjectTracker := Object clone do ( newSlot("subject") )
  Suite clone setSubject("pass subject") append(
    Spec with("track subject", block(subjectTracker setSubject(subject)))
  ) run
  subjectTracker subject == "pass subject"
)

assert("Suite => clone of subject per spec",
  tracker := list
  Suite clone setSubject(tracker) append(
    Spec clone setName("add data to clone of list") setExampleBlock(block(
      subject append("ignored")
    ))
  ) run
  tracker == list()
)

assert("Suite => reports passed spec", 
  report := RecordingReport clone
  Suite clone setSubject("suite") setReport(report) append(
    Spec clone setName("passed spec") setExampleBlock(block( nil ))
  ) run
  report passedSpecs == list("passed spec")
)

assert("Suite => reports failed spec",
  report := RecordingReport clone
  Suite clone setSubject("reporting") setReport(report) append(
    Spec clone setName("failed spec") setExampleBlock(block(
      Exception raise("spec that fails for asserting a failure")
    ))
  ) run
  report failedSpecs keys == list("failed spec")
)

assert("Suite => reports cause with failed spec",
  report := RecordingReport clone
  Suite clone setSubject("reporting") setReport(report) append(
    Spec clone setName("failed spec") setExampleBlock(block(
      Exception raise("failure cause")
    ))
  ) run
  reportedException := report failedSpecs values at(0)
  reportedException error == "failure cause"
)

assert("Suite => reports pending spec",
  report := RecordingReport clone
  Suite clone setSubject("reporting") setReport(report) append(
    Spec clone setName("pending spec") setExampleBlock(block(
      pending
    ))
  ) run
  report pendingSpecs == list("pending spec")
)

assert("Suite => reports start of context",
  report ::= RecordingReport clone
  Suite clone setSubject("reporting") setReport(report) append(DummySpec clone) run
  report startedContexts == list("reporting")
)

assert("Suite => reports end of context",
  report ::= RecordingReport clone
  Suite clone setSubject("reporting") setReport(report) append(DummySpec clone) run
  report endedContexts == list("reporting")
)

