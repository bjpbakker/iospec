module(iospec) do (
  module(cli) do (
    SpecFilesArgument := Object clone do (
      defaultFnpattern := "*_spec.io"

      init := method(
        newSlot("root")
        newSlot("fnpattern")
      )

      with := method(arg,
        SpecFilesArgument clone setRoot(determineRoot(arg)) setFnpattern(determineFnpattern(arg))
      )

      determineFnpattern := method(arg,
        if (qualifiesAsRootDir(arg), defaultFnpattern, fnpatternFrom(arg))
      )

      determineRoot := method(arg,
        if (qualifiesAsRootDir(arg), arg, rootFrom(arg))
      )

      fnpatternFrom := method(arg,
        Directory with(arg) name
      )

      rootFrom := method(arg,
        Directory with(arg) parentDirectory path
      )

      qualifiesAsRootDir := method(path,
        Directory with(path) exists
      )
    )
  )
)
