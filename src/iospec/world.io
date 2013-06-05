World := Object clone do (
  init := method(
    self suites := list
  )

  register := method(suite,
    self suites append(suite)
    self
  )
)

