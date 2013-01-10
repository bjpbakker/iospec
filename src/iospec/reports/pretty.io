Pretty := Object clone do (
  stack := method(callStack, prefix,
    callStack map(description) map(asMutable) map(appendSeq("\n")) reduce(with)
  )

  indent := method(seq, prefix,
    lines := seq split("\n")
    lines map(prependSeq(prefix)) map(appendSeq("\n")) reduce(with)
  )
)

