#!/usr/bin/env io

tests := method(dir,
  dir recursiveFilesOfTypes(list("_test.io"))
)

exit := method(error,
  error showStack
  System exit(1)
)

write("Running IoSpec tests\n")
workingDir := Directory with(Directory currentWorkingDirectory)
error := try (
  tests(workingDir directoryNamed("test")) foreach (file,
    doFile(file path)
  )
)
error and exit(error)

write("\n",
  "Running IoSpec examples\n")
System system("./bin/iospec examples/*_example.io")

