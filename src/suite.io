Suite := Object clone

Suite describe := method(subject,
  group := Suite clone
  group subject := subject
  group __report := NullReport
  group
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
  if (spec_result is_passed,
    report pass(spec description),
    report fail(spec description, spec_result cause)
  )
)

