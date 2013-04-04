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
    if (qualifiesAsRootDir(arg), defaultFnpattern, parseFnpattern(arg))
  )

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

