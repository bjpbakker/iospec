SpecFilesArgument := Object clone do (
  newSlot("root")
  newSlot("fnpattern")

  with := method(arg,
    SpecFilesArgument clone
      setRoot(determineRoot(arg))
      setFnpattern(determineFnpattern(arg))
  )

  determineFnpattern := method(arg,
    if (qualifiesAsRootDir(arg), defaultFnpattern, parseFnpattern(arg))
  )

  defaultFnpattern := "*_spec.io"

  parseFnpattern := method(arg,
    Directory with(arg) name
  )

  determineRoot := method(arg,
    if (qualifiesAsRootDir(arg), arg, parseRoot(arg))
  )

  parseRoot := method(arg,
    Directory with(arg) parentDirectory path
  )

  qualifiesAsRootDir := method(path,
    Directory with(path) exists
  )
)

