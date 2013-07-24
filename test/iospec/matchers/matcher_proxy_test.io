module(iospec) do (
  module(matchers) do (
    assert("MatcherProxy => get proxy that supports message",
      proxy := MatcherProxy proxy("equal")
      proxy slotNames contains("equal")
    )

    assert("MatcherProxy => proxy returns result of lambda",
      proxy := MatcherProxy proxy("exec", block("result"))
      proxy exec == "result"
    )

    assert("MatcherProxy => proxy passes arguments to the lambda",
      proxy := MatcherProxy proxy("exec", block(expected, expected))
      proxy exec("expected") == "expected"
    )

    assert("MatcherProxy => proxy evaluates arguments in context of sender",
      expected := "<value>"
      proxy := MatcherProxy proxy("exec", block(expected, expected))
      proxy exec(expected) == "<value>"
    )

    assert("MatcherProxy => proxy passes list as multiple arguments given",
      proxy := MatcherProxy proxy("exec", block(expected, expected))
      proxy exec(1,2,3) == list(1,2,3)
    )

    assert("MatcherProxy => proxy passes nil as no arguments given",
      proxy := MatcherProxy proxy("exec", block(expected, expected))
      proxy exec == nil
    )

    assert("MatcherProxy => supports multiple executions",
      proxy := MatcherProxy proxy("exec", block(arg, arg))
      results := list
      results append(proxy exec(5))
      results append(proxy exec(6))
      results == list(5,6)
    )
  )
)
