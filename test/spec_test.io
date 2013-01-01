doRelativeFile("test_helper.io")

assert("Spec => spec can pass",
  result := Spec that("truth", "is true") do (
    true
  )
  result isPassed == true
)

assert("Spec => spec can fail",
  result := Spec that("spec", "fails") do (
    AssertionError raise("false")
  )
  result isPassed == false
)

assert("Spec => failed spec result includes cause",
  result := Spec that("failing spec result", "includes cause") do (
    AssertionError raise("cause")
  )
  result cause isKindOf(AssertionError)
)

assert("Spec => spec executes on subject",
  result := Spec that("subject", "is not empty") do (
    isEmpty == false
  )
  if (result cause, result cause isPassed, true)
)

