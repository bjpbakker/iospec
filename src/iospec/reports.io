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
    error := "     " .. cause type .. ": " .. cause error .. "\n"
    write("\n\n",
      "Failues:\n\n",
      failure,
      red(error),
      red(Pretty stack(cause coroutine callStack, "     ")),
      "\n\n"
    )
  )
)

Pretty := Object clone
Pretty stack := method(callStack, prefix,
  s := Sequence clone
  callStack foreach(stack,
    s appendSeq(
      if(prefix, prefix, ""),
      stack description,
      "\n"
    )
  )
  s
)

