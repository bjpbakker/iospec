Pending := Exception clone
Spec := Object clone do (
  newSlot("name")
  newSlot("exampleBlock")

  with := method(name, exampleBlock,
    self clone setName(name) setExampleBlock(exampleBlock)
  )

  run := method(subject,
    e := try ( evaluateOn(subject, self exampleBlock) )
    resultFromPossibleEvaluationError(e)
  )

  evaluateOn := method(subject, blk,
    ctx := Object clone do (
      newSlot("subject")
      pending := method(Pending raise)
    ) setSubject(subject)
    ctx doMessage(blk message)
  )

  resultFromPossibleEvaluationError := method(error,
    if (error == nil,
      PassingSpec clone,
      if (error isKindOf(Pending),
        PendingSpec clone,
        FailingSpec clone setCause(error)
      )
    )
  )
)

PassingSpec := Object clone do (
  isPassed := true
  isFailed := nil
  isPending := nil
)
PendingSpec := Object clone do (
  isPending := true
  isPassed := nil
  isFailed := nil
)
FailingSpec := Object clone do (
  newSlot("cause")
  isFailed := true
  isPassed := nil
  isPending := nil
)

