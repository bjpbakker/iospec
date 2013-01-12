ProgressReport := Colorizer clone do (
  newSlot("pending_specs", list)
  newSlot("failing_specs", Map clone)
  newSlot("context")

  pass := method(
    green(".") print
  )

  pending := method(spec,
    pending_specs append(
      Object clone do (
        newSlot("context")
        newSlot("spec")
      ) setContext(context) setSpec(spec)
    )
    yellow("*") print
  )

  fail := method(spec, cause,
    failing_specs atPut(spec, cause)
    red("F") print
  )

  start_context := method(context,
    setContext(context)
  )

  end_context := method(
    if (pending_specs size > 0, report_pending)
    if (failing_specs size > 0, report_failures)
    writeln
  )

  report_pending := method(
    write("\n\n", "Pending:\n")
    pending_specs foreach(pending,
      description := Sequence with(pending context type, " ", pending spec)
      write(yellow(Pretty indent(description, "  "), "\n"))
    )
  )

  report_failures := method(
    write("\n\n",
      "Failues:\n\n")
    number := 0
    failing_specs foreach(spec, cause,
      number = number + 1
      failure := "  " .. number .. ") " .. spec .. "\n"
      write(failure,
        red(Pretty indent(format_cause(cause), "     ")),
        "\n\n"
      )
    )
  )

  format_cause := method(cause,
    if (cause isKindOf(ExpectationNotMetError),
      cause error,
      Sequence with(cause type, ": ", cause error, "\n",
        Pretty stack(cause coroutine callStack)))
  )
)

