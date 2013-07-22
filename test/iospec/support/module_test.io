assert("module => define a module",
  module(test)
  test
)

assert("module => define a value in a module",
  module(test) do (
    value := "module value"
  )
  test value == "module value"
)

assert("module => module slots are scoped",
  module(test) do (
    value := "module"
  )
  getSlot("value") == nil
)

assert("module => objects can access module's slots",
  module(test) do (
    value := "value"
    Getter := Object clone do (
      get := method(value)
    )
  )
  test Getter get
)

assert("module => objects in module have fully qualified access to module",
  module(test) do (
    moduleName := test __name
  )
  test moduleName
)

assert("module => contains its name",
  module(test) __name == "test"
)

assert("module => extend module if module defined multiple times",
  module(test) do (
    attr1 := nil
  )
  module(test) do (
    attr2 := nil
  )
  test slotNames containsAll(list("attr1", "attr2"))
)

assert("module => define a nested module",
  module(test) do (
    module(nested) do (
      value := "nested"
    )
  )
  test nested value
)

assert("module => nested module has fully qualified name",
  module(test) do (
    module(nested) do (
    )
  )
  test nested __name == "test nested"
)
