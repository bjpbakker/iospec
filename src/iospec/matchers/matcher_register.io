module(iospec) do (
  module(matchers) do (
    MatcherRegister := Object clone do (
      newSlot("register", Map clone)

      put := method(name, matcher,
        register atPut(name, matcher)
      )

      get := method(name,
        if (register hasKey(name),
          register at(name),
          Operator clone setOperator(name))
      )
    )
  )
)
