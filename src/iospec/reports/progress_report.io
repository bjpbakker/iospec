ProgressReport := Colorizer clone
ProgressReport clone := method(
  resend
  self failures := Map clone
  self
)
ProgressReport pass := method(
  green(".") print
)
ProgressReport fail := method(spec, cause,
  failures atPut(spec, cause)
  red("F") print
)
ProgressReport start_context := method(nil)
ProgressReport end_context := method(
  number := 0
  failures foreach(spec, cause,
    number = number + 1
    failure := "  " .. number .. ") " .. spec .. "\n"
    write("\n\n",
      "Failues:\n\n",
      failure,
      red(Pretty indent(format_cause(cause), "     ")),
      "\n\n"
    )
  )
)
ProgressReport format_cause := method(cause,
  if (cause isKindOf(ExpectationNotMetError),
    cause error,
    Sequence with(cause type, ": ", cause error, "\n",
      Pretty stack(cause coroutine callStack)))
)

