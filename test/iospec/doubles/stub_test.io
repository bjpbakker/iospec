module(iospec) do (
  module(doubles) do (
    assert("Stub => returns stub result for function",
      double := Stub clone
      double stub("f", double)
      double f == double
    )

    assert("Stub => returns second stub result for second function call",
      double := Stub clone
      double stub("f", "a")
      double stub("f", "b")
      double f
      double f == "b"
    )

    assert("Stub => returns last return value for any remaining calls",
      double := Stub clone stub("f", "value")
      double f
      double f == "value"
    )

    assert("Stub => throws if function is not stubbed",
      double := Stub clone
      e := try (double f)
      e isKindOf(UnknownMessageError)
    )

    assert("Stub => allows chaining stub set up",
      double := Stub clone stub("f", "chained-stub")
      double f == "chained-stub"
    )
  )
)
