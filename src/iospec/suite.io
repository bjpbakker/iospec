Suite := Object clone

Suite describe := method(subject,
  suite := Suite clone
  suite subject := subject
  suite __report := NullReport
  suite
)

Suite report_to := method(report,
  self __report := report
  self
)

Suite do := method(
  __report start_context(subject)
  resend
  __report end_context(subject)
)

Suite it := method(description,
  spec := Spec that(subject, description)
  ReportingSpec wrap(spec, __report)
)

ReportingSpec := Object clone
ReportingSpec wrap := method(spec, report,
  reporting_spec := ReportingSpec clone
  reporting_spec spec := spec
  reporting_spec report := report
  reporting_spec
)
ReportingSpec do := method(
  spec_result := call delegateTo(spec)
  spec_result map_passed(
    block(report pass(spec description))
  )
  spec_result map_pending(
    block(report pending(spec description))
  )
  spec_result map_failed(
    block(cause, report fail(spec description, cause))
  )
)

