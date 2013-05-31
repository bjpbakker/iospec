Mock := Object clone do (
  init := method(
    newSlot("receivedMessages", list)
  )

  forward := method(
    message := call message
    receivedMessages append(message name)
    MockAnswer
  )

  hasReceived := method(messageName,
    receivedMessages contains(messageName)
  )
)

MockAnswer := Object clone

