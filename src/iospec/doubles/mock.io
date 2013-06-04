UnexpectedMessage := Exception clone
ExpectedMessageNotReceived := Exception clone

Mock := Object clone do (
  init := method(
    newSlot("toReceive", list)
    newSlot("received", list)
    newSlot("ignored", list)
  )

  shouldReceive := method(function,
    toReceive append(function)
  )

  ignore := method(function,
    ignored append(function)
  )

  forward := method(
    name := call message name
    if (toReceive contains(name) or ignored contains(name),
      received append(name),
      UnexpectedMessage raise(name))
  )

  verify := method(
    received containsAll(toReceive) or
      ExpectedMessageNotReceived raise(formatError)
  )

  formatError := method(
    "expected, but not received: " .. toReceive difference(received)
      .. "received, but not expected: " .. received difference(toReceive)
  )
)
