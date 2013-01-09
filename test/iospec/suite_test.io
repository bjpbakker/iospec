doRelativeFile("test_helper.io")

assert("Suite => defines specs on subject", 
  Suite describe("subject")
)

assert("Suite => runs a spec",
  run := Object clone
  run subject := nil
  Suite describe("subject") do (
    it ("runs spec on subject") do ( run subject := subject )
  )
  run subject == "subject"
)

assert("Suite => report_to returns self",
  suite := Suite describe("report_to")
  suite report_to(RecordingReport clone) == suite
)

assert("Suite => reports passed spec", 
  report := RecordingReport clone
  Suite describe("Suite reporting") do (
    report_to(report)

    it ("reports passed spec") do (
      nil
    )
  )
  report passed_specs contains("reports passed spec")
)

assert("Suite => reports failed spec",
  report := RecordingReport clone
  Suite describe("Suite reporting") do (
    report_to(report)

    it ("reports failed spec") do (
      AssertionError raise("failed spec")
    )
  )
  report failed_specs hasKey("reports failed spec")
)

assert("Suite => reports cause with failed spec",
  report := RecordingReport clone
  Suite describe("Suite reporting") do (
    report_to(report)

    it ("reports cause for failed spec") do (
      AssertionError raise("cause")
    )
  )
  report failed_specs values at(0) isKindOf(AssertionError)
)

assert("Suite => reports pending spec",
  report := RecordingReport clone
  Suite describe("Suite reporting") do (
    report_to(report)

    it ("reports pending spec") do (
      pending
    )
  )
  report pending_specs contains("reports pending spec")
)

assert("Suite => reports start of context",
  report := RecordingReport clone
  spec_group := Suite describe("Suite reporting")
  spec_group report_to(report)
  spec_group do ( nil )
  report started_contexts contains("Suite reporting")
)

assert("Suite => reports end of context",
  report := RecordingReport clone
  spec_group := Suite describe("Suite reporting")
  spec_group report_to(report)
  spec_group do ( nil )
  report ended_contexts contains("Suite reporting")
)

