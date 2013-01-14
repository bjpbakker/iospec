Mock := Object clone do (
  newSlot("receivedMessages", list)

  forward := method(
    message := call message
    receivedMessages append(message name)
  )

  hasReceived := method(messageName,
    receivedMessages contains(messageName)
  )
)

