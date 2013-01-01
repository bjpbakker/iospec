Spec ::= Object clone
Spec that ::= method(subject, description,
  spec := self clone
  spec _subject := subject
  spec _description := description
  spec
)

Spec do ::= method(
  SpecResult of (
    try (
      _subject doMessage(call message argAt(0))
    )
  )
)

SpecResult ::= Object clone
SpecResult of := method(exception,
  result := SpecResult clone
  result __exception := exception
  result
)
SpecResult cause := method(self __exception)
SpecResult isPassed := method(self __exception == nil)

