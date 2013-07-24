module(iospec) do (
  module(support) do (
    Colors := Object clone do (
      esc := 27 asCharacter
      normal := esc .. "[0;m"
      red := esc .. "[0;31m"
      green := esc .. "[0;32m"
      yellow := esc .. "[0;33m"
    )
    Colors clone := Colors

    Colorizer := Object clone do (
      colors := Colors clone

      green := method(text,
        colorize(text, colors green)
      )

      red := method(text,
        colorize(text, colors red)
      )

      yellow := method(text,
        colorize(text, colors yellow)
      )

      colorize := method(text, color,
        color .. text .. colors normal
      )
    )
  )
)
