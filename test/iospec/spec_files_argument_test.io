doRelativeFile("test_helper.io")

assert("SpecFilesArgument => fnpattern defaults to specs",
  SpecFilesArgument with("test") fnpattern == "*_spec.io"
)

assert("SpecFilesArgument => parses fnpattern from arg if arg includes pattern",
  SpecFilesArgument with("test/*_test.io") fnpattern == "*_test.io"
)

assert("SpecFilesArgument => root is argument if dir exists",
  SpecFilesArgument with("test") root == "test"
)

assert("SpecFilesArgument => parses root from arg if arg includes pattern",
  SpecFilesArgument with("test/*_spec.io") root == "test"
)

