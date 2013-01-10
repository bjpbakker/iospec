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
        execution_context(subject) doMessage(call message argAt(0))
      )
    )
  )

  execution_context := method(subject,
    ctx := subject do (
      newSlot("subject")
      pending := method(Pending raise)
    )
    ctx setSubject(ctx)
  )
)

SpecResult := Object clone do (
  newSlot("cause")

  map_passed := method(lambda,
    if(cause == nil,
      lambda call)
  )

  map_failed := method(lambda,
    if (cause != nil and cause isKindOf(Pending) not,
      lambda call(cause))
  )

  map_pending := method(lambda,
    if (cause isKindOf(Pending),
      lambda call)
  )
)

