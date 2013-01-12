SpecFilesArgument := Object clone do (
  newSlot("root")
  newSlot("fnpattern")

  with := method(arg,
    SpecFilesArgument clone
      setRoot(determine_root(arg))
      setFnpattern(determine_fnpattern(arg))
  )

  determine_fnpattern := method(arg,
    if (qualifies_as_root_dir(arg), default_fnpattern, parse_fnpattern(arg))
  )

  default_fnpattern := "*_spec.io"

  parse_fnpattern := method(arg,
    Directory with(arg) name
  )

  determine_root := method(arg,
    if (qualifies_as_root_dir(arg), arg, parse_root(arg))
  )

  parse_root := method(arg,
    Directory with(arg) parentDirectory path
  )

  qualifies_as_root_dir := method(path,
    Directory with(path) exists
  )
)

