Object should := method(
  match_message := call message next
  call message setNext(nil)
  Should in_context(self, match_message) matches
)

Should ::= Object clone
Should in_context := method (subject, message,
  s := Should clone
  s subject := subject
  s match_msg := message
  s
)
Should matches := method(
  m := OperatorMatcher clone
  m actual := subject
  m matches(match_msg)
)

