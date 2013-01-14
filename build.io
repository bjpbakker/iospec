#!/usr/bin/env io

tests := method(dir,
  dir recursiveFilesOfTypes(list("_test.io"))
)

write("Running IoSpec tests\n")
workingDir := Directory with(Directory currentWorkingDirectory)
tests(workingDir directoryNamed("test")) foreach (file,
  doFile(file path)
)

write("\n",
  "Running IoSpec examples\n")
System system("./bin/iospec examples/*_example.io")

