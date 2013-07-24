module(iospec) do (
  module(cli) do (
    assert("Options => gets default formatter as formatter is not specified",
      opts := Options with(list)
      opts formatter isKindOf(iospec reports formatters Progress)
    )

    assert("Options => gets custom formatter",
      opts := Options with(list("--formatter", "documentation"))
      opts formatter isKindOf(iospec reports formatters Documentation)
    )

    assert("Options => gets non-options as arguments",
      opts := Options with(list("arg1", "arg2"))
      opts arguments == list("arg1", "arg2")
    )

    assert("Options => gets any options after -- as arguments",
      opts := Options with(list("--formatter", "progress", "--", "arg1", "arg2"))
      opts arguments == list("arg1", "arg2")
    )

    assert("Options => gets args from non-option as arguments",
      opts := Options with(list("--formatter", "progress", "arg1", "arg2"))
      opts arguments == list("arg1", "arg2")
    )

    assert("Options => throws if unknown option is called",
      ex := try ( Options with(list("--unknown-option", "value")) )
      ex isKindOf(UnknownOptions)
    )

    assert("Options => throws if option has no value",
      ex := try ( Options with(list("--formatter")) )
      ex isKindOf(ValueRequiredForOption)
    )

    assert("Options => throws if unknown option has no value",
      ex := try ( Options with(list("--unknown-option")) )
      ex isKindOf(UnknownOptions)
    )
  )
)
