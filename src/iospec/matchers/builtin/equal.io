module(iospec) do (
  module(matchers) do (
    Equal := BaseMatcher clone do (
      matchForShould := method(
        actual == expected
      )

      matchForShouldNot := method(
        matchForShould not
      )

      failureMessageForShould := method(
        msg := "expected: #{expected}\n     got: #{actual}\n\n(compared using ==)\n"
        msg interpolate(self)
      )

      failureMessageForShouldNot := method(
        msg := "expected: not #{expected}\n     got: #{actual}\n\n(compared using ==)\n"
        msg interpolate(self)
      )
    )

    Equal register("equal")
  )
)
