doRelativeFile("core/spec.io")
doRelativeFile("core/suite.io")
doRelativeFile("core/matchers.io")
doRelativeFile("core/dsl.io")
doRelativeFile("core/runner.io")
doRelativeFile("core/world.io")
doRelativeFile("core/spec_files_argument.io")
doRelativeFile("core/file_collector.io")

doRelativeFile("reports/colorizer.io")
doRelativeFile("reports/pretty.io")
doRelativeFile("reports/null_report.io")
doRelativeFile("reports/progress_report.io")

doRelativeFile("doubles/mock.io")
doRelativeFile("doubles/stub.io")

IoSpec := Object clone do (
  newSlot("report", ProgressReport clone)
  newSlot("world", World clone)
)
IoSpec clone := IoSpec

