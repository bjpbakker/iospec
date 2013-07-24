module(iospec) do (
  module(reports) do (
    module(formatters) do (
      BaseFormatter := Object clone do (
        startContext := nil
        endContext := nil

        finish := method(stats,
          write("\n\n")
          write("#{total} examples, #{failed} failures\n\n" interpolate(stats))
        )

        dumpPending := method(pendingSpecs,
          write("\n\n", "Pending:\n")
          pendingSpecs foreach(pending,
            description := Sequence with(contextAsText(pending context), " ", pending spec)
            write(yellow(iospec support Pretty indentLines(description, "  ")), "\n")
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
              red(iospec support Pretty indentLines(formatCause(cause), "     ")),
              "\n\n"
            )
          )
        )

        formatCause := method(cause,
          if (cause isKindOf(iospec matchers ExpectationNotMetError),
            cause error,
            Sequence with(cause type, ": ", cause error, "\n",
              formatStackTrace(cause coroutine callStack)))
        )

        contextAsText := method(value,
          if (value isKindOf(Sequence),
            value,
            value type)
        )

        formatStackTrace := method(callStack, prefix,
          callStack map(description) map(asMutable) map(appendSeq("\n")) reduce(with)
        )
      )
    )
  )
)
