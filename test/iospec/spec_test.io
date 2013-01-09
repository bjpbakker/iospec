doRelativeFile("test_helper.io")

SpecResult raise_or := method(value,
  if (is_passed, value, cause pass)
)

assert("Spec => has a description",
  spec := Spec that("subject", "has some feature")
  spec description == "has some feature"
)

assert("Spec => spec can pass",
  result := Spec that("truth", "is true") do (
    true
  )
  result is_passed == true
)

assert("Spec => spec can fail",
  result := Spec that("spec", "fails") do (
    AssertionError raise("false")
  )
  result is_passed == false
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
  result raise_or(true)
)

assert("Spec => can be pending",
  result := Spec that("subject", "has pending feature") do (
    pending
  )
  result is_pending
)

