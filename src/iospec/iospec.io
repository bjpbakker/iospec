doRelativeFile("core/spec.io")
doRelativeFile("core/suite.io")
doRelativeFile("core/world.io")
doRelativeFile("core/runner.io")
doRelativeFile("core/file_collector.io")
doRelativeFile("core/spec_files_argument.io")

doRelativeFile("matchers/matcher_register.io")
doRelativeFile("matchers/matcher_proxy.io")
doRelativeFile("matchers/error.io")

doRelativeFile("matchers/builtin/base_matcher.io")
doRelativeFile("matchers/builtin/equal.io")
doRelativeFile("matchers/builtin/operator.io")

doRelativeFile("dsl/dsl.io")
doRelativeFile("dsl/should.io")

doRelativeFile("reports/colorizer.io")
doRelativeFile("reports/pretty.io")
doRelativeFile("reports/null_report.io")
doRelativeFile("reports/report.io")
doRelativeFile("reports/formatters/base_formatter.io")
doRelativeFile("reports/formatters/progress.io")

doRelativeFile("doubles/mock.io")
doRelativeFile("doubles/stub.io")

IoSpec := Object clone do (
  newSlot("report", Report clone setFormatter(Progress))
  newSlot("world", World clone)
)
IoSpec clone := IoSpec

