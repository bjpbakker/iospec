module(iospec) do (
  module(reports) do (
    module(formatters) do (
      Documentation := BaseFormatter clone do (
        appendProto(iospec support Colorizer)

        pass := method(context, spec,
          green(format(context, spec)) println
        )

        pending := method(context, spec,
          yellow(format(context, spec)) println
        )

        fail := method(context, spec,
          red(format(context, spec)) println
        )

        format := method(context, spec,
          contextAsText(context) .. " " .. spec
        )
      )
    )
  )
)
