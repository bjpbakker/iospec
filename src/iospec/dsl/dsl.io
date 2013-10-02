Object describe := method(subject,
  iospec dsl describe(subject)
)

module(iospec) do (
  module(dsl) do (
    describe := method(subject,
      DSL clone describe(subject)
    )

    DSL := Object clone do (
      suite := nil

      describe := method(subject,
        self suite := iospec core Suite clone setSubject(subject)
        iospec world register(self suite)
        self
      )

      do := method(
        call resend
        self suite
      )

      it := method(name,
        SpecBuilder describe(name, self suite)
      )

      SpecBuilder := Object clone do (
        newSlot("spec")

        describe := method(name, suite,
          spec := iospec core Spec with(name, block(pending))
          suite append(spec)
          self clone setSpec(spec)
        )

        do := method(
          msg := call message argAt(0)
          spec setExampleBlock(block() setMessage(msg))
        )
      )
    )
  )
)
