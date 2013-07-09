withSpec := method(name,
  Spec clone setName(name)
)

raiseIfFailed := method(result,
  result isFailed and result cause pass
)

assertPassed := method(result,
  raiseIfFailed(result)
  result isPassed
)

assertPending := method(result,
  raiseIfFailed(result)
  result isPending
)

assertFailed := method(result,
  result isFailed
)

ExpectedExceptionForFailure := Exception clone
passingBlock := block(true)
failingBlock := block(ExpectedExceptionForFailure raise)
pendingBlock := block(pending)

assert("Spec => has a name",
  spec := Spec clone setName("has some feature")
  spec name == "has some feature"
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
  cause := result cause
  cause isKindOf(ExpectedExceptionForFailure)
)

assert("Spec => has accesss to subject",
  result := Spec clone setName("is not empty") setExampleBlock(block(
    subject isEmpty == false
  )) run("subject")
  assertPassed(result)
)
