doRelativeFile("test_helper.io")

assert("DSL::describe => describes a subject",
  describe("subject") type == Suite type
)

assert("DSL::describe => registers suite in IoSpec world",
  world := Mock clone
  IoSpec setWorld(world)
  describe("subject")
  world hasReceived("register")
)

assert("DSL::describe => reports to configured report",
  IoSpec setReport(CountingReport clone)
  describe("IoSpec report") do (
    it ("passes") do (nil)
  ) run
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

