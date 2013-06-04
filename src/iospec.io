doRelativeFile("iospec/spec.io")
doRelativeFile("iospec/suite.io")
doRelativeFile("iospec/matchers.io")
doRelativeFile("iospec/doubles/mock.io")
doRelativeFile("iospec/doubles/stub.io")
doRelativeFile("iospec/reports/colorizer.io")
doRelativeFile("iospec/reports/pretty.io")
doRelativeFile("iospec/reports/null_report.io")
doRelativeFile("iospec/reports/progress_report.io")
doRelativeFile("iospec/dsl.io")
doRelativeFile("iospec/runner.io")
doRelativeFile("iospec/world.io")
doRelativeFile("iospec/spec_files_argument.io")
doRelativeFile("iospec/file_collector.io")

IoSpec := Object clone do (
  newSlot("report", ProgressReport clone)
  newSlot("world", World clone)
)
IoSpec clone := IoSpec

