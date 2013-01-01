doRelativeFile("test_helper.io")

assert("spec can pass",
  result := Spec that("truth", "is true") do (
    true
  )
  result isPassed == true
)

assert("spec can fail",
  result := Spec that("spec", "fails") do (
    AssertionError raise("false")
  )
  result isPassed == false
)

assert("failed spec result includes cause",
  result := Spec that("failing spec result", "includes cause") do (
    AssertionError raise("cause")
  )
  result cause isKindOf(AssertionError)
)

assert("spec executes on subject",
  result := Spec that("subject", "is not empty") do (
    isEmpty == false
  )
  if (result cause, result cause isPassed, true)
)

