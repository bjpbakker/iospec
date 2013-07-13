Report := Colorizer clone do (
  newSlot("formatter")

  newSlot("pendingSpecs", list)
  newSlot("failedSpecs", Map clone)
  newSlot("context")

  newSlot("formatter")

  pass := method(
    formatter pass
  )

  pending := method(spec,
    pendingSpecs append(
      Object clone do (
        newSlot("context")
        newSlot("spec")
      ) setContext(context) setSpec(spec)
    )
    formatter pending
  )

  fail := method(spec, cause,
    failedSpecs atPut(spec, cause)
    formatter fail
  )

  startContext := method(context,
    setContext(context)
  )

  endContext := method(
    setContext(nil)
  )

  startRun := method(nil)

  dump := method(
    if (pendingSpecs size > 0, formatter dumpPending(pendingSpecs))
    if (failedSpecs size > 0, formatter dumpFailures(failedSpecs))
    writeln
  )
)

