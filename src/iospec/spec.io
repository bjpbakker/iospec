Pending := Exception clone
Spec := Object clone do (
  newSlot("subject")
  newSlot("description")

  that := method(subject, description,
    self clone setSubject(subject) setDescription(description)
  )

  do := method(
    SpecResult clone setCause (
      try (
        executionContext(subject) doMessage(call message argAt(0))
      )
    )
  )

  executionContext := method(subject,
    ctx := subject do (
      newSlot("subject")
      pending := method(Pending raise)
    )
    ctx setSubject(ctx)
  )
)

SpecResult := Object clone do (
  newSlot("cause")

  mapPassed := method(lambda,
    if(cause == nil,
      lambda call)
  )

  mapFailed := method(lambda,
    if (cause != nil and cause isKindOf(Pending) not,
      lambda call(cause))
  )

  mapPending := method(lambda,
    if (cause isKindOf(Pending),
      lambda call)
  )
)

