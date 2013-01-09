Spec := Object clone
Spec that := method(subject, description,
  spec := self clone
  spec subject := subject
  spec description := description
  spec
)

Spec do := method(
  SpecResult clone setCause (
    try (
      ctx := ExecutionContext clone setSubject(subject)
      ctx doMessage(call message argAt(0))
    )
  )
)

Pending := Exception clone
ExecutionContext := Object clone do (
  newSlot("subject")

  pending := method(nil)
  forward := method(
    subject doMessage(thisMessage)
  )
)

SpecResult := Object clone do (
  newSlot("cause")

  is_passed := method(
    (cause == nil) or cause isKindOf(Pending)
  )

  is_pending := method(true)
)

