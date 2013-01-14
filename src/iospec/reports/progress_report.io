ProgressReport := Colorizer clone do (
  newSlot("pendingSpecs", list)
  newSlot("failingSpecs", Map clone)
  newSlot("context")

  pass := method(
    green(".") print
  )

  pending := method(spec,
    pendingSpecs append(
      Object clone do (
        newSlot("context")
        newSlot("spec")
      ) setContext(context) setSpec(spec)
    )
    yellow("*") print
  )

  fail := method(spec, cause,
    failingSpecs atPut(spec, cause)
    red("F") print
  )

  startContext := method(context,
    setContext(context)
  )

  endContext := method(
    setContext(nil)
  )

  start := method(nil)

  startDump := method(
    if (pendingSpecs size > 0, reportPending)
    if (failingSpecs size > 0, reportFailures)
    writeln
  )

  reportPending := method(
    write("\n\n", "Pending:\n")
    pendingSpecs foreach(pending,
      description := Sequence with(pending context type, " ", pending spec)
      write(yellow(Pretty indent(description, "  "), "\n"))
    )
  )

  reportFailures := method(
    write("\n\n",
      "Failues:\n\n")
    number := 0
    failingSpecs foreach(spec, cause,
      number = number + 1
      failure := "  " .. number .. ") " .. spec .. "\n"
      write(failure,
        red(Pretty indent(formatCause(cause), "     ")),
        "\n\n"
      )
    )
  )

  formatCause := method(cause,
    if (cause isKindOf(ExpectationNotMetError),
      cause error,
      Sequence with(cause type, ": ", cause error, "\n",
        Pretty stack(cause coroutine callStack)))
  )
)

