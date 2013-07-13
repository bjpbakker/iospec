Progress := BaseFormatter clone do (
  appendProto(Colorizer)

  pass := method( green(".") print )
  pending := method( yellow("*") print )
  fail := method( red("F") print )
)
