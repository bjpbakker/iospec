Object describe := method(subject,
  DSL clone describe(subject)
)

DSL := Object clone do (
  suite := nil

  describe := method(subject,
    self suite := Suite clone setSubject(subject) setReport(IoSpec report)
    IoSpec world register(self suite)
    self
  )

  do := method(
    call resend
    self suite
  )

  it := method(name,
    SpecDescriber clone setSuite(self suite) setSpecName(name)
  )

  SpecDescriber := Object clone do (
    newSlot("suite")
    newSlot("specName")

    do := method(
      msg := call message argAt(0)
      suite append(Spec clone setName(specName) setExampleBlock(block() setMessage(msg)))
    )
  )
)

Object should := method(
  extractMatcher := method(chain,
    matcher := chain next
    lastOfMatcher := matcher lastBeforeEndOfLine
    chain setNext(lastOfMatcher next)
    lastOfMatcher setNext(nil)
    matcher
  )
  matcher := extractMatcher(call message) asMessageWithEvaluatedArgs(call sender)
  Should clone setActual(self) setMatcher(matcher) matches
)

Should := Object clone do (
  newSlot("actual")
  newSlot("matcher")

  matches := method(
    OperatorMatcher clone setActual(actual) matches(matcher)
  )
)
