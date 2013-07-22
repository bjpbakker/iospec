#!/usr/bin/env io

doRelativeFile("src/iospec/iospec.io")
doRelativeFile("test/helpers/assert.io")
doRelativeFile("test/iospec/helpers/reports.io")
doRelativeFile("test/iospec/helpers/file.io")

IoSpecTestRunner := Object clone do (
  modules := list("support", "doubles", "core", "matchers", "reports", "dsl", "cli")

  run := method(
    modules foreach(module,
      TestStats reset
      write("Testing IoSpec ", module asCapitalized, "\n\n")
      passed := IoSpecModule clone setName(module) run
      printResults(module)
      if (passed == false,
        write("Holding execution of following modules because of test failure(s)\n\n")
        System exit(2))
    )
  )

  printSuiteError := method(suite, ex,
    write(Colorizer red(
      "Failed to load suite in " .. suite .. " (" .. ex type .. ex error .. ")\n"
    ))
  )

  printResults := method(module,
    write("\n",
          "Results for IoSpec module ", module asCapitalized, ":\n",
          "\n",
          "  ", moduleStats, "\n\n\n")
  )

  moduleStats := method(
    "Passed [#{pass}] :: Failed [#{fail}] :: Error [#{error}] :: Pending [#{pending}]" \
      interpolate(TestStats)
  )
)

TestModuleNotFound := Exception clone

IoSpecModule := Object clone do (
  init := method(
    newSlot("name")
  )

  run := method(
    errors := runSuites()
    errors foreach(suite, ex,
      write(Colorizer red("Failed to load suite in " .. suite .. " (" .. ex type .. " " .. ex error .. ")\n"))
    )
    TestStats error + TestStats fail + errors size == 0
  )

  runSuites := method(
    errors := Map clone
    tests foreach(file,
      error := try (
        IoSpecTestSuite clone doFile(file path)
      )
      if (error, errors atPut(file path, error))
    )
    errors
  )

  tests := method(
    dir := Directory with("./test/iospec") at(name)
    if (dir not,
      TestModuleNotFound raise(name))
    dir recursiveFilesOfTypes(list("_test.io"))
  )
)

IoSpecTestSuite := Object clone

IoSpecTestRunner run

write("Running IoSpec examples\n")
examplesResult := System system("./bin/iospec -- examples/*_example.io")
System exit(examplesResult)

