module(iospec) do (
  module(core) do (
    World := Object clone do (
      init := method(
        self suites := list
      )

      register := method(suite,
        self suites append(suite)
        self
      )
    )
  )
)
