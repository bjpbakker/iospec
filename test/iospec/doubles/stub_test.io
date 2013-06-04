doRelativeFile("../test_helper.io")

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

assert("Stub => throws if function is not stubbed",
  double := Stub clone
  e := try (double f)
  e isKindOf(UnknownMessageError)
)

