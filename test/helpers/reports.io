RecordingReport ::= Object clone

RecordingReport clone := method(
  report := resend
  report started_contexts := list
  report ended_contexts := list
  report passed_specs := list
  report failed_specs := Map clone
  report
)

RecordingReport start_context := method(context,
  started_contexts append(context)
)

RecordingReport end_context := method(context,
  ended_contexts append(context)
)

RecordingReport pass := method(spec_description,
  passed_specs append(spec_description)
)

RecordingReport fail := method(spec_description, cause,
  failed_specs atPut(spec_description, cause)
)

