DummySpec := Spec with("dummy", block(nil))

raiseOnFailCallback := block(name, result,
  if (result isFailed) then (
    result cause pass
  )
)

assert("Suite => runs a spec",
  spec := Mock clone shouldReceive("run")
  suite := Suite clone setSubject("suite") append(spec)
  suite run(block)
  spec verify
)

assert("Suite => passes clone of subject to spec",
  tracker := list
  Suite clone setSubject(tracker) append(
    Spec with("add data to clone of list", block(subject append("ignored")))
  ) run(block)
  tracker == list()
)

assert("Suite => calls block with result of running spec",
  spec := Spec with("passing", block(nil))
  callback := Object clone do (
    call := method(name, result,
      self name := name
      self result := result
    )
  )
  Suite clone setSubject("yield to block") append(spec) run(callback)
  callback name != nil and callback result != nil
)
