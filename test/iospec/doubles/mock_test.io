assert("Mock => verifies expected and recieved message",
  mock := Mock clone
  mock shouldReceive(doSomething)
  mock doSomething
  mock verify
)

assert("Mock => verify throws if expectations are not met",
  mock := Mock clone
  mock shouldReceive(doSomething)
  e := try ( mock verify )
  e isKindOf(ExpectationsNotMet) or e pass
)

assert("Mock => verify throws if unknown message received",
  mock := Mock clone
  mock doSomething
  e := try ( mock verify )
  e isKindOf(ExpectationsNotMet) or e pass
)

assert("Mock => does not verify ignored messages",
  mock := Mock clone
  mock ignore(function)
  mock function
  mock verify
)

assert("Mock => can ignore multiple messages",
  mock := Mock clone
  mock ignore(one, two)
  mock one
  mock two
  mock verify
)

assert("Mock => message names can be passed as sequences",
  mock := Mock clone
  mock shouldReceive("one")
  mock one
  mock verify
)
