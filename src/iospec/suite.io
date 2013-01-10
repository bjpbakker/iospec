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
    report start_context(subject)
    resend
    report end_context(subject)
  )

  it := method(description,
    spec := Spec setSubject(subject clone) setDescription(description)
    ReportingSpec clone setSpec(spec) setReport(report)
  )
)

ReportingSpec := Object clone do (
  newSlot("spec")
  newSlot("report")

  do := method(
    spec_result := call delegateTo(spec)
    spec_result map_passed(block(
      report pass(spec description)
    ))
    spec_result map_pending(block(
      report pending(spec description)
    ))
    spec_result map_failed(block(
      cause, report fail(spec description, cause)
    ))
  )
)
