RecordingReport := Object clone do (
  init := method(
    newSlot("startedContexts", list)
    newSlot("endedContexts", list)
    newSlot("passedSpecs", list)
    newSlot("pendingSpecs", list)
    newSlot("failedSpecs", Map clone)
  )

  startContext := method(context,
    startedContexts append(context)
  )

  endContext := method(context,
    endedContexts append(context)
  )

  pass := method(spec,
    passedSpecs append(spec)
  )

  pending := method(spec,
    pendingSpecs append(spec)
  )

  fail := method(spec, cause,
    failedSpecs atPut(spec, cause)
  )
)

CountingReport := Object clone do (
  init := method(
    newSlot("startedContexts", 0)
    newSlot("endedContexts", 0)
    newSlot("passedSpecs", 0)
    newSlot("pendingSpecs", 0)
    newSlot("failedSpecs", 0)
  )

  startContext := method(
    self startedContexts := startedContexts + 1
  )

  endContext := method(
    self endedContexts := endedContexts + 1
  )

  pass := method(
    self passedSpecs := passedSpecs + 1
  )

  pending := method(
    self pendingSpecs := pendingSpecs + 1
  )

  fail := method(
    self failedSpecs := failedSpecs + 1
  )
)

