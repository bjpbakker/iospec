Report := Colorizer clone do (
  newSlot("formatter")

  init := method(
    newSlot("pendingSpecs", list)
    newSlot("failedSpecs", Map clone)
    newSlot("context")
  )

  pass := method(spec,
    formatter pass(context, spec)
  )

  pending := method(spec,
    pendingSpecs append(
      Object clone do (
        newSlot("context")
        newSlot("spec")
      ) setContext(context) setSpec(spec)
    )
    formatter pending(context, spec)
    self
  )

  fail := method(spec, cause,
    failedSpecs atPut(spec, cause)
    formatter fail(context, spec)
    self
  )

  startContext := method(context,
    setContext(context)
    formatter startContext(context)
    self
  )

  endContext := method(
    setContext(nil)
    formatter endContext
    self
  )

  start := method( self )

  finish := method(stats,
    if (pendingSpecs size > 0, formatter dumpPending(pendingSpecs))
    if (failedSpecs size > 0, formatter dumpFailures(failedSpecs))
    formatter finish(stats)
    self
  )
)

