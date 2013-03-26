doRelativeFile("test_helper.io")

assert("DSL::describe => describes a subject",
  describe("subject") type == Suite type
)

assert("DSL::describe => reports to configured report",
  IoSpec report := CountingReport clone
  describe("IoSpec report") do (
    it ("passes") do (nil)
  )
  IoSpec report passedSpecs == 1
)

assert("DSL::should => handles possitive expectation",
  "text" should == "text"
)

assert("DSL::should => fails when expectation not met",
  failure := try (
    "text" should == "fail"
  )
  failure != nil
)

