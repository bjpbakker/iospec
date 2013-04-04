doRelativeFile("test_helper.io")

withSpec := method(description,
  Spec clone setDescription(description)
)

raiseIfFailed := method(result,
  result ifFailed(block(cause, cause pass))
)

assertPassed := method(result,
  raiseIfFailed(result)
  result ifPassed(block(true))
)

assertPending := method(result,
  raiseIfFailed(result)
  result ifPending(block(true))
)

assertFailed := method(result,
  result ifFailed(block(true))
)

passingBlock := block(true)
failingBlock := block(AssertionError raise("expected"))
pendingBlock := block(pending)

assert("Spec => has a description",
  spec := Spec clone setDescription("has some feature")
  spec description == "has some feature"
)

assert("Spec => can pass",
  result := withSpec("passing spec") setExampleBlock(passingBlock) run("subject")
  assertPassed(result)
)

assert("Spec => can be pending",
  result := withSpec("pending spec") setExampleBlock(pendingBlock) run("subject")
  assertPending(result)
)

assert("Spec => can fail",
  result := withSpec("failing spec") setExampleBlock(failingBlock) run("subject")
  assertFailed(result)
)

assert("Spec => failure result includes cause",
  result := withSpec("failing spec") setExampleBlock(failingBlock) run("subject")
  cause := result ifFailed(block(cause, cause))
  cause isKindOf(AssertionError)
)

assert("Spec => runs on subject",
  result := Spec clone setDescription("is not empty") setExampleBlock(block(
    isEmpty == false
  )) run("subject")
  assertPassed(result)
)

