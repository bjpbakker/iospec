Object describe := method(subject,
  Suite describe(subject) setReport(IoSpec report)
)

Object should := method(
  matcher := call message next
  call message setNext(nil)
  Should clone setContext(self) setMatcher(matcher) matches
)

Should := Object clone do (
  newSlot("context")
  newSlot("matcher")

  matches := method(
    OperatorMatcher clone setActual(context) matches(matcher)
  )
)

