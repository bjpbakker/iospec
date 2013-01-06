Spec := Object clone
Spec that := method(subject, description,
  spec := self clone
  spec subject := subject
  spec description := description
  spec
)

Spec do := method(
  SpecResult of (
    try (
      subject doMessage(call message argAt(0))
    )
  )
)

SpecResult := Object clone
SpecResult of := method(exception,
  result := SpecResult clone
  result __exception := exception
  result
)
SpecResult cause := method(self __exception)
SpecResult is_passed := method(self __exception == nil)

