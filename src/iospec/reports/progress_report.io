ColorDotReport := Colorizer clone
ColorDotReport clone := method(
  resend
  self failures := Map clone
  self
)
ColorDotReport pass := method(
  green(".") print
)
ColorDotReport fail := method(spec, cause,
  failures atPut(spec, cause)
  red("F") print
)
ColorDotReport start_context := method(nil)
ColorDotReport end_context := method(
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
ColorDotReport format_cause := method(cause,
  if (cause isKindOf(ExpectationNotMetError),
    cause error,
    Sequence with(cause type, ": ", cause error, "\n",
      Pretty stack(cause coroutine callStack)))
)

