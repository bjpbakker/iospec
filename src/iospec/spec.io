Pending := Exception clone
Spec := Object clone do (
  newSlot("name")
  newSlot("exampleBlock")

  run := method(subject,
    e := try ( evaluateOn(subject, self exampleBlock) )
    makeResultFromPossibleEvaluationError(e)
  )

  makeResultFromPossibleEvaluationError := method(error,
    if (error == nil,
      PassingSpec clone,
      if (error isKindOf(Pending),
        PendingSpec clone,
        FailingSpec clone setCause(error)
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

PassingSpec := Object clone do (
  ifPassed := method(lambda, lambda call)
  ifFailed := nil
  ifPending := nil
)
PendingSpec := Object clone do (
  ifPending := method(lambda, lambda call)
  ifPassed := nil
  ifFailed := nil
)
FailingSpec := Object clone do (
  newSlot("cause")
  ifFailed := method(lambda, lambda call(cause))
  ifPassed := nil
  ifPending := nil
)

