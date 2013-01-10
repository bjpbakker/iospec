Colors := Object clone do (
  esc := 27 asCharacter
  normal := esc .. "[0;m"
  red := esc .. "[0;31m"
  green := esc .. "[0;32m"
  yellow := esc .. "[0;33m"
)
Colors clone := Colors

Colorizer := Object clone do (
  green := method(text,
    colorize(text, Colors green)
  )

  red := method(text,
    colorize(text, Colors red)
  )

  yellow := method(text,
    colorize(text, Colors yellow)
  )

  colorize := method(text, color,
    color .. text .. Colors normal
  )
)

