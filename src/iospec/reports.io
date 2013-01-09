NullReport := Object clone
NullReport pass := method(nil)
NullReport fail := method(nil)
NullReport start_context := method(nil)
NullReport end_context := method(nil)

Colors := Object clone
Colors clone := method(self)
Colors esc ::= method(27 asCharacter)
Colors normal ::= method(esc .. "[0;m")
Colors red ::= method(esc .. "[0;31m")
Colors green ::= method(esc .. "[0;32m")

Colorizer := Object clone
Colorizer green := method(text,
  Colors green .. text .. Colors normal
)
Colorizer red := method(text,
  Colors red .. text .. Colors normal
)

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

Pretty := Object clone
Pretty stack := method(callStack, prefix,
  callStack map(description) map(asMutable) map(appendSeq("\n")) reduce(with)
)
Pretty indent := method(seq, prefix,
  lines := seq split("\n")
  lines map(prependSeq(prefix)) map(appendSeq("\n")) reduce(with)
)

