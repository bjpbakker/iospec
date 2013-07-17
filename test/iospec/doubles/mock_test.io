assert("Mock => verify expected and recieved message",
  mock := Mock clone
  mock shouldReceive("doSomething")
  mock doSomething
  mock verify
)

assert("Mock => throws if expectations are not met",
  mock := Mock clone
  mock shouldReceive("doSomething")
  e := try (
    mock verify
  )
  e isKindOf(ExpectedMessageNotReceived) or e pass
)

assert("Mock => throws if unknown message received",
  mock := Mock clone
  e := try ( mock doSomething )
  e isKindOf(UnexpectedMessage)
)

assert("Mock => does not verify ignored messages",
  mock := Mock clone
  mock ignore("function")
  mock function
  mock verify
)

assert("Mock => can ignore multiple messages",
  mock := Mock clone
  mock ignore("one", "two")
  mock one
  mock two
  mock verify
)

