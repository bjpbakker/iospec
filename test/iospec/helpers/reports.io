RecordingReport := Object clone
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

CountingReport := Object clone
CountingReport clone := method(
  report := resend
  report started_contexts := 0
  report ended_contexts := 0
  report passed_specs := 0
  report failed_specs := 0
  report
)
CountingReport start_context := method(
  self started_contexts := started_contexts + 1
)
CountingReport end_context := method(
  self ended_contexts := ended_contexts + 1
)
CountingReport pass := method(
  self passed_specs := passed_specs + 1
)
CountingReport fail := method(
  self failed_specs := failed_specs + 1
)

