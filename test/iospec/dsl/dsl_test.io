module(iospec) do (
  module(dsl) do (
    assert("DSL::describe => registers suite in IoSpec world",
      world := iospec doubles Mock clone
      world shouldReceive(register)
      iospec world := world
      describe("subject")
      world verify
    )

    assert("DSL::describe => sets subject on suite",
      suite := describe("subject") do ()
      suite subject == "subject"
    )

    assert("DSL::it => appends spec to suite",
      suite := describe("DSL") do (
        it ("creates a spec") do (nil)
      )
      suite specs size == 1
    )

    assert("DSL::it => is pending as no do-block given",
      suite := describe("it") do (
        it ("is pending as no block is given")
      )
      suite specs size == 1
      suite specs at(0) run isPending
    )
  )
)
