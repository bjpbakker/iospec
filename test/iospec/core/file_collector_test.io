assert("FileCollector => collects Io files in directory",
  tmp := tmpDir("/tmp/iospec")
  file := tmp file("file.io")
  files := FileCollector clone setDirectory(tmp path) collect
  tmp cleanup
  files == list(file path)
)

assert("FileCollector => collects files by pattern",
  tmp := tmpDir("/tmp/iospec")
  mySpec := tmp file("my_spec.io")
  otherFile := tmp file("other_file.io")
  matchingFiles := FileCollector clone setDirectory(tmp path) collect("*_spec.io")
  tmp cleanup
  matchingFiles == list(mySpec path)
)

