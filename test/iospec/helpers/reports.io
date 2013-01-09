RecordingReport := Object clone do (
  newSlot("started_contexts", list)
  newSlot("ended_contexts", list)
  newSlot("passed_specs", list)
  newSlot("pending_specs", list)
  newSlot("failed_specs", Map clone)

  start_context := method(context,
    started_contexts append(context)
  )

  end_context := method(context,
    ended_contexts append(context)
  )

  pass := method(spec_description,
    passed_specs append(spec_description)
  )

  pending := method(spec_description,
    pending_specs append(spec_description)
  )

  fail := method(spec_description, cause,
    failed_specs atPut(spec_description, cause)
  )
)

CountingReport := Object clone do (
  newSlot("started_contexts", 0)
  newSlot("ended_contexts", 0)
  newSlot("passed_specs", 0)
  newSlot("pending_specs", 0)
  newSlot("failed_specs", 0)

  start_context := method(
    self started_contexts := started_contexts + 1
  )

  end_context := method(
    self ended_contexts := ended_contexts + 1
  )

  pass := method(
    self passed_specs := passed_specs + 1
  )

  pending := method(
    self pending_specs := pending_specs + 1
  )

  fail := method(
    self failed_specs := failed_specs + 1
  )
)

