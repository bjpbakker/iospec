doRelativeFile("test_helper.io")

assert("Runner => executes a file", 
  tmp := tmpDir("/tmp/iospec")
  file := tmp file("text.io") open write(
    "File with(\"/tmp/iospec/data\") create"
  ) close
  Runner clone setFiles(list(file path)) setReport(NullReport) run
  hasRun := File with("/tmp/iospec/data") exists
  tmp cleanup
  hasRun
)

assert("Runner => throws if cannot do file",
  tmp := tmpDir("/tmp/iospec")
  file := tmp file("fail.io") open write(
    "nonExistingCall"
  ) close
  e := try (
    Runner clone setFiles(list(file path)) setReport(NullReport) run
  )
  tmp cleanup
  e != nil
)

assert("Runner => sends 'start' to report",
  report := Mock clone
  Runner clone setFiles(list) setReport(report) run
  report hasReceived("start")
)

assert("Runner => starts dump report",
  report := Mock clone
  Runner clone setFiles(list) setReport(report) run
  report hasReceived("startDump")
)

