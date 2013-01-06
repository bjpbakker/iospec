doRelativeFile("test_helper.io")

assert("should => handles possitive expectation",
  "text" should == "text"
)
assert("should => fails when expectation not met",
  try (
    "text" should == "fail"
  ) != nil
)

