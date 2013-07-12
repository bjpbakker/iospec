#!/usr/bin/env io

doRelativeFile("test/iospec/test_helper.io")

TestModuleNotFound := Exception clone

testsFor := method(module,
  dir := Directory with("./test/iospec") at(module)
  if (dir not,
    TestModuleNotFound raise(module))
  dir recursiveFilesOfTypes(list("_test.io"))
)

exit := method(error,
  error showStack
  System exit(1)
)

modules := list("doubles", "core", "matchers", "dsl")
modules foreach(module,
  write("Testing IoSpec ", module asCapitalized, "\n")
  error := try (
    testsFor(module) foreach(file,
      doFile(file path)
    )
  )
  if (error,
    exit(error))
  write("\n",
        "tests for IoSpec module ", module asCapitalized, " were run successfully\n",
        "\n")
)

write("\n",
  "Running IoSpec examples\n")
examplesResult := System system("./bin/iospec examples/*_example.io")
System exit(examplesResult)

