Object describe := method(subject,
  suite := Suite clone setSubject(subject) setReport(IoSpec report) do (
    it := method(name,
      spec := Spec clone setDescription(name)
      append(spec)
      spec
    )
  )
  IoSpec world register(suite)
  suite
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

