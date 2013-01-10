doRelativeFile("test_helper.io")

assert("Suite => describes a subject", 
  Suite describe("subject") isKindOf(Suite)
)

assert("Suite => runs a spec",
  run := Object clone do (
    newSlot("subject")
  )
  Suite describe("subject") do (
    it ("runs spec on subject") do (
      run setSubject(subject)
    )
  )
  run subject == "subject"
)

assert("Suite => new subject per spec",
  run := Object clone do (
    newSlot("size")
  )
  Suite describe(list) do (
    it ("adds a number") do (
      append(1)
    )
    it ("is empty") do (
      run setSize(size)
    )
  )
  run size == 0
)

assert("Suite => reports passed spec", 
  report := RecordingReport clone
  Suite describe("Suite reporting") setReport(report) do (
    it ("reports passed spec") do ( nil )
  )
  report passed_specs contains("reports passed spec")
)

assert("Suite => reports failed spec",
  report := RecordingReport clone
  Suite describe("Suite reporting") setReport(report) do (
    it ("reports failed spec") do (
      AssertionError raise("failed spec")
    )
  )
  report failed_specs hasKey("reports failed spec")
)

assert("Suite => reports cause with failed spec",
  report := RecordingReport clone
  Suite describe("Suite reporting") setReport(report) do (
    it ("reports cause for failed spec") do (
      AssertionError raise("cause")
    )
  )
  report failed_specs values at(0) isKindOf(AssertionError)
)

assert("Suite => reports pending spec",
  report := RecordingReport clone
  Suite describe("Suite reporting") setReport(report) do (
    it ("reports pending spec") do ( pending )
  )
  report pending_specs contains("reports pending spec")
)

assert("Suite => reports start of context",
  report := RecordingReport clone
  Suite describe("Suite reporting") setReport(report) do ( nil )
  report started_contexts contains("Suite reporting")
)

assert("Suite => reports end of context",
  report := RecordingReport clone
  Suite describe("Suite reporting") setReport(report) do ( nil )
  report ended_contexts contains("Suite reporting")
)

