#!/usr/bin/env io

doRelativeFile("test/iospec/test_helper.io")

TestModuleNotFound := Exception clone

testsFor := method(module,
  dir := Directory with("./test/iospec") at(module)
  if (dir not,
    TestModuleNotFound raise(module))
  dir recursiveFilesOfTypes(list("_test.io"))
)

exitBecauseFailed := method(
  System exit(2)
)

moduleStats := method(
  "Passed [#{pass}] :: Failed [#{fail}] :: Error [#{error}] :: Pending [#{pending}]" \
    interpolate(TestStats)
)

modules := list("doubles", "core", "matchers", "dsl", "cli")
modules foreach(module,
  write("Testing IoSpec ", module asCapitalized, "\n\n")
  TestStats reset
  error := try (
    testsFor(module) foreach(file,
      doFile(file path)
    )
  )
  write("\n",
        "Results for IoSpec module ", module asCapitalized, ":\n",
        "\n",
        "  ", moduleStats, "\n\n\n")
  if (TestStats error + TestStats fail > 0,
    write("Holding execution of following modules because of test failure(s)\n\n")
    exitBecauseFailed)
)

write("Running IoSpec examples\n")
examplesResult := System system("./bin/iospec -- examples/*_example.io")
System exit(examplesResult)

