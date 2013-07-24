module(iospec) do (
  module(core) do (
    Spec := Object clone do (
      Pending := Exception clone
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
        ctx := ExecutionContext with(subject, block(Pending raise))
        blk clone setScope(ctx) call
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

    ExecutionContext := Object clone do (
      init := method(
        newSlot("subject")
        newSlot("onPending")
      )

      with := method(subject, onPending,
        self clone setSubject(subject) setOnPending(onPending)
      )

      pending := method( onPending call )
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
  )
)
