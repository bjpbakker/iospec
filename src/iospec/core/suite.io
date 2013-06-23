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
    results := list
    specs foreach(spec,
      result := spec run(subject clone)
      reportSpec(spec, result)
      results append(result)
    )
    report endContext(subject)
    results
  )

  reportSpec := method(spec, result,
    result isPassed and report pass(spec name)
    result isPending and report pending(spec name)
    result isFailed and report fail(spec name, result cause)
  )
)

