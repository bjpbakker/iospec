doRelativeFile("test_helper.io")

assert("Runner => executes a file", 
  tmp := tmp_dir("/tmp/iospec")
  file := tmp file("text.io") open write(
    "File with(\"/tmp/iospec/data\") create"
  ) close
  Runner clone setFiles(list(file path)) run
  has_run := File with("/tmp/iospec/data") exists
  tmp cleanup
  has_run
)
assert("Runner => throws if cannot do file",
  tmp := tmp_dir("/tmp/iospec")
  file := tmp file("fail.io") open write(
    "non_existing_call"
  ) close
  e := try (
    Runner clone setFiles(list(file path)) run
  )
  tmp cleanup
  e != nil
)

