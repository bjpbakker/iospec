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
    result mapPassed(block(
      report pass(spec description)
    ))
    result mapPending(block(
      report pending(spec description)
    ))
    result mapFailed(block(cause,
      report fail(spec description, cause)
    ))
  )
)

