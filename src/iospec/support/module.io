module := method(
  name := call argAt(0) name
  m := self getSlot(name)
  if (m == nil) then (
    m := Module with(name, if (self isKindOf(Module), self))
    newSlot(name, m)
  )
  m
)

Module := Object clone do (
  with := method(name, optionalParent,
    m := self clone
    m __name := formatModuleName(name, optionalParent)
    m type := "[" .. m __name .. "]"
    m newSlot(name, m)
    m newSlot("Object", ForwardToModule clone setModule(m))
    m
  )

  formatModuleName := method(name, optionalParent,
    if (optionalParent,
      optionalParent __name .. " " .. name,
      name)
  )

  ForwardToModule := Object clone do (
    newSlot("module")
    forward := method( call delegateTo(module) )
  )
)
Module appendProto(Lobby)
