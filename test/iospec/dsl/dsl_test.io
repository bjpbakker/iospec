assert("DSL::describe => registers suite in IoSpec world",
  world := Mock clone
  world shouldReceive("register")
  IoSpec setWorld(world)
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

assert("DSL::describe => reports to configured report",
  IoSpec setReport(CountingReport clone)
  describe("IoSpec report") do (
    it ("passes") do (nil)
  ) run
  IoSpec report passedSpecs == 1
)