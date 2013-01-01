collectTests := method(dir,
  dir recursiveFilesOfTypes(list("_test.io"))
)

workingDir := Directory with(Directory currentWorkingDirectory)
collectTests(workingDir) foreach (file, doFile(file path))

