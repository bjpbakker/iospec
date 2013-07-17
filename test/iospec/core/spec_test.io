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
  spec := Spec with("has some feature")
  spec name == "has some feature"
)

assert("Spec => can pass",
  result := Spec with("passing spec", passingBlock) run("subject")
  assertPassed(result)
)

assert("Spec => can be pending",
  result := Spec with("pending spec", pendingBlock) run("subject")
  assertPending(result)
)

assert("Spec => can fail",
  result := Spec with("failing spec", failingBlock) run("subject")
  assertFailed(result)
)

assert("Spec => failure result includes cause",
  result := Spec with("failing spec", failingBlock) run("subject")
  cause := result cause
  cause isKindOf(ExpectedExceptionForFailure)
)

assert("Spec => has accesss to subject",
  result := Spec with("is not empty", block(subject isEmpty == false)) run("subject")
  assertPassed(result)
)
