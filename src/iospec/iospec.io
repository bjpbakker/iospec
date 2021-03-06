doRelativeFile("support/module.io")

doRelativeFile("support/colorizer.io")
doRelativeFile("support/pretty.io")

doRelativeFile("core/spec.io")
doRelativeFile("core/suite.io")
doRelativeFile("core/world.io")
doRelativeFile("core/stats.io")
doRelativeFile("core/runner.io")

doRelativeFile("matchers/matcher_register.io")
doRelativeFile("matchers/matcher_proxy.io")
doRelativeFile("matchers/error.io")

doRelativeFile("matchers/builtin/base_matcher.io")
doRelativeFile("matchers/builtin/equal.io")
doRelativeFile("matchers/builtin/operator.io")

doRelativeFile("dsl/dsl.io")
doRelativeFile("dsl/should.io")

doRelativeFile("reports/report.io")
doRelativeFile("reports/formatters/base_formatter.io")
doRelativeFile("reports/formatters/documentation.io")
doRelativeFile("reports/formatters/progress.io")

doRelativeFile("doubles/mock.io")
doRelativeFile("doubles/stub.io")

doRelativeFile("cli/options.io")
doRelativeFile("cli/file_collector.io")
doRelativeFile("cli/spec_files_argument.io")

module(iospec) do (
  report := iospec reports Report clone
  world := iospec core World clone

  useFormatter := method(formatter,
    report setFormatter(formatter)
  )
)
