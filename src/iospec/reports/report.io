Report := Colorizer clone do (
  newSlot("formatter")

  newSlot("pendingSpecs", list)
  newSlot("failedSpecs", Map clone)
  newSlot("context")

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
  )

  fail := method(spec, cause,
    failedSpecs atPut(spec, cause)
    formatter fail(context, spec)
  )

  startContext := method(context,
    setContext(context)
  )

  endContext := method(
    setContext(nil)
  )

  start := nil

  finish := method(
    if (pendingSpecs size > 0, formatter dumpPending(pendingSpecs))
    if (failedSpecs size > 0, formatter dumpFailures(failedSpecs))
    writeln
  )
)

