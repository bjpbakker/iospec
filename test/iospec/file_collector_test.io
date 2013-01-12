doRelativeFile("test_helper.io")

assert("FileCollector => collects Io files in directory",
  tmp := tmp_dir("/tmp/iospec")
  file := tmp file("file.io")
  files := FileCollector clone setDirectory(tmp path) collect
  tmp cleanup
  files == list(file path)
)

assert("FileCollector => collects files by pattern",
  tmp := tmp_dir("/tmp/iospec")
  my_spec := tmp file("my_spec.io")
  other_file := tmp file("other_file.io")
  matching_files := FileCollector clone setDirectory(tmp path) collect("*_spec.io")
  tmp cleanup
  matching_files == list(my_spec path)
)

