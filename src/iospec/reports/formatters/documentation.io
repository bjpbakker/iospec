Documentation := BaseFormatter clone do (
  appendProto(Colorizer)

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
