module(iospec) do (
  module(reports) do (
    module(formatters) do (
      Progress := BaseFormatter clone do (
        appendProto(iospec support Colorizer)

        pass := method( green(".") print )
        pending := method( yellow("*") print )
        fail := method( red("F") print )
      )
    )
  )
)
