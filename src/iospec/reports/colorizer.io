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

