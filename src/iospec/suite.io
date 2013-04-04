Suite := Object clone do (

  init := method(
    newSlot("subject")
    newSlot("specs", list())
    newSlot("report", NullReport)
  )

  append := method(spec,
    specs append(spec)
    self
  )

  run := method(
    report startContext(subject)
    specs foreach(spec,
      reportSpec(spec, spec run(subject clone))
    )
    report endContext(subject)
  )

  reportSpec := method(spec, result,
    result ifPassed(block(
      report pass(spec name)
    ))
    result ifPending(block(
      report pending(spec name)
    ))
    result ifFailed(block(cause,
      report fail(spec name, cause)
    ))
  )
)

