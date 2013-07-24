module(iospec) do (
  module(matchers) do (
    MatcherProxy := Object clone do (
      newSlot("matcher")

      proxy := method(messageName, lambda,
        p := self clone
        p newSlot("lambda", lambda)
        p setSlot(messageName, method(
          lambda call(parseExpectedArgs(call message arguments, call sender))
        ))
        p
      )

      parseExpectedArgs := method(arguments, context,
        args := arguments map(arg, context doMessage(arg))
        if (args size == 0,
          nil,
          if (args size == 1,
            args at(0),
            args))
      )
    )
  )
)
