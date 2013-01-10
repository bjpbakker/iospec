doRelativeFile("test_helper.io")

assert("describe => describes a subject",
  describe("subject") type == Suite type
)

assert("describe => reports to configured report",
  IoSpec report := CountingReport clone
  describe("IoSpec report") do (
    it ("passes") do (nil)
  )
  IoSpec report passed_specs == 1
)

assert("should => handles possitive expectation",
  "text" should == "text"
)

assert("should => fails when expectation not met",
  failure := try (
    "text" should == "fail"
  )
  failure != nil
)

