Spec := Object clone do (
  newSlot("subject")
  newSlot("description")

  that := method(subject, description,
    self clone setSubject(subject) setDescription(description)
  )

  do := method(
    SpecResult clone setCause (
      try (
        ctx := ExecutionContext clone setSubject(subject)
        ctx doMessage(call message argAt(0))
      )
    )
  )
)

Pending := Exception clone
ExecutionContext := Object clone do (
  newSlot("subject")

  pending := method(Pending raise)
  forward := method(
    subject doMessage(thisMessage)
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

