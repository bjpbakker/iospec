module(iospec) do (
  module(doubles) do (
    ExpectationsNotMet := Exception clone

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
        received append(name)
      )

      verify := method(
        if (notReceived size > 0 or notExpected size > 0) then ( 
          iospec doubles ExpectationsNotMet raise(formatError)
        )
        true
      )

      formatError := method(
        "expected, but not received [" .. notReceived join(", ") .. "]; " \
          .. "received, but not expected [" .. notExpected join(", ") .. "]"
      )

      notReceived := method(
        toReceive difference(received)
      )

      notExpected := method(
        received difference(knownMessages)
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
  )
)
