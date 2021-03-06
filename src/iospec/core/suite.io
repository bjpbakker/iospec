module(iospec) do (
  module(core) do (
    Suite := Object clone do (

      init := method(
        newSlot("subject")
        newSlot("specs", list())
      )

      append := method(spec,
        specs append(spec)
        self
      )

      run := method(callback,
        specs foreach(spec,
          result := spec run(subject clone)
          callback call(spec name, result)
        )
      )
    )
  )
)
