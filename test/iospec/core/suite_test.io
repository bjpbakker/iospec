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
    Spec with("add data to clone of list", block(subject append("ignored")))
  ) run
  tracker == list()
)

assert("Suite => calls block with result of running spec",
  spec := Spec with("passing", block(nil))
  yieldToBlockState := Object clone
  Suite clone setSubject(tracker) append(spec) run(block(name, result,
    yieldToBlockState value := (name != nil and result != nil)
  ))
  yieldToBlockState value
)
