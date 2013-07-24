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
        SpecDescriber clone setSuite(self suite) setSpecName(name)
      )

      SpecDescriber := Object clone do (
        newSlot("suite")
        newSlot("specName")

        do := method(
          msg := call message argAt(0)
          suite append(iospec core Spec with(specName, block() setMessage(msg)))
        )
      )
    )
  )
)
