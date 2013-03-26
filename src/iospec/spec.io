Pending := Exception clone
Spec := Object clone do (
  newSlot("description")
  newSlot("exampleBlock")

  do := method(
    msg := call message argAt(0)
    self setExampleBlock(block() setMessage(msg))
    self
  )

  run := method(subject,
    e := try ( evaluateOn(subject, self exampleBlock) )
    makeResultFromPossibleEvaluationError(e)
  )

  makeResultFromPossibleEvaluationError := method(error,
    if (error == nil,
      PassedSpec clone,
      if (error isKindOf(Pending),
        PendingSpec clone,
        FailedSpec clone setCause(error)
      )
    )
  )

  evaluateOn := method(subject, blk,
    ctx := subject do (
      newSlot("subject")
      pending := method(Pending raise)
    ) setSubject(subject)
    ctx doMessage(blk message)
  )
)

PassedSpec := Object clone do (
  mapPassed := method(lambda, lambda call)
  mapFailed := nil
  mapPending := nil
)
PendingSpec := Object clone do (
  mapPending := method(lambda, lambda call)
  mapPassed := nil
  mapFailed := nil
)
FailedSpec := Object clone do (
  newSlot("cause")
  mapFailed := method(lambda, lambda call(cause))
  mapPassed := nil
  mapPending := nil
)

