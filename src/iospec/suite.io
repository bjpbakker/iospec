Suite := Object clone do (
  newSlot("subject")
  newSlot("report")

  describe := method(subject,
    suite := Suite clone
    suite setSubject(subject)
    suite setReport(NullReport)
    suite
  )

  do := method(
    report startContext(subject)
    resend
    report endContext(subject)
  )

  it := method(description,
    spec := Spec clone setSubject(subject clone) setDescription(description)
    ReportingSpec clone setSpec(spec) setReport(report)
  )
)

ReportingSpec := Object clone do (
  newSlot("spec")
  newSlot("report")

  do := method(
    result := call delegateTo(spec)
    result mapPassed(block(
      report pass(spec description)
    ))
    result mapPending(block(
      report pending(spec description)
    ))
    result mapFailed(block(
      cause, report fail(spec description, cause)
    ))
  )
)
