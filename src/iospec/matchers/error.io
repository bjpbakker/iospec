ExpectationNotMetError := Exception clone

ErrorMessage := Object clone do (
  format := method(expected, actual, matcher,
    ctx := Context from(expected, actual, matcher)
    "expected: #{expected}\n     got: #{actual} (using #{matcher})" interpolate(ctx)
  )

  Context := Object clone do (
    newSlot("expected")
    newSlot("actual")
    newSlot("matcher")

    escape := method(value,
      value asString asMutable escape
    )

    setExpected := method(expected,
      self expected = escape(expected)
      self
    )

    setActual := method(actual,
      self actual := escape(actual)
      self
    )

    from := method(expected, actual, matcher,
      self clone setExpected(expected) setActual(actual) setMatcher(matcher)
    )
  )
)

