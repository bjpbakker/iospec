UnknownMessageError := Exception clone

Stub := Object clone do (
  init := method(
    newSlot("stubbed", list)
  )
  
  stub := method(function, answer,
    stub := selectStub(function)
    if (stub not,
      stub := newStub(function)
      stubbed append(stub))
    stub answers append(answer)
    self
  )

  newStub := method(function,
    Object clone do (
      newSlot("function")
      newSlot("answers", list)
    ) setFunction(function)
  )


  forward := method(
    name := call message name
    stub := selectStub(name)
    if (stub,
      stub answers removeFirst,
      UnknownMessageError raise(name))
  )

  selectStub := method(name,
    stubs := stubbed select(stub,
      stub function == name
    )
    stubs first
  )
)

