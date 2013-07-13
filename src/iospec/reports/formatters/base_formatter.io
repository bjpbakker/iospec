BaseFormatter := Object clone do (
  dumpPending := method(pendingSpecs,
    write("\n\n", "Pending:\n")
    pendingSpecs foreach(pending,
      description := Sequence with(pending context type, " ", pending spec)
      write(yellow(Pretty indent(description, "  "), "\n"))
    )
  )

  dumpFailures := method(failedSpecs,
    write("\n\n",
      "Failues:\n\n")
    number := 0
    failedSpecs foreach(spec, cause,
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
