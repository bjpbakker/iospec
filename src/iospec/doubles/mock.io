UnexpectedMessage := Exception clone
ExpectedMessageNotReceived := Exception clone

Mock := Object clone do (
  init := method(
    newSlot("toReceive", list)
    newSlot("received", list)
    newSlot("ignored", list)
  )

  shouldReceive := method(
    function := getMessageName(call argAt(0), call sender)
    toReceive append(function)
    self
  )

  ignore := method(
    call message arguments foreach(arg,
      function := getMessageName(arg, call sender)
      ignored append(function)
    )
    self
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
    "expected, but not received: " .. toReceive difference(received) .. "; " \
      .. "received, but not expected: " .. received difference(knownMessages)
  )

  knownMessages := method(
    result := list
    result appendSeq(toReceive)
    result appendSeq(ignored)
    result
  )

  getMessageName := method(message, sender,
    if (message name beginsWithSeq("\""),
      sender doMessage(message),
      message name)
  )
)
