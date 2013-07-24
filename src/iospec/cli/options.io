module(iospec) do (
  module(cli) do (
    Options := Object clone do (
      newSlot("arguments")

      optionNames := list("formatter")

      defaultOptions := Map clone
      defaultOptions atPut("formatter", "progress")

      with := method(argv,
        parser := OptionParser with(argv)
        options := defaultOptions merge(parser options)
        self clone setOptions(options) setArguments(parser arguments)
      )

      setOptions := method(options,
        validate(options)

        options keys foreach(opt,
          if (options hasKey(opt),
            value := loadObject(options at(opt))
            self setSlot(opt, value))
        )
        self
      )

      validate := method(options,
        unknownOptions := options keys difference(optionNames)
        if (unknownOptions size > 0,
          UnknownOptions raise(unknownOptions join(", ")))
        unsetOptions := options keys select(k, options at(k) == nil)
        if (unsetOptions size > 0,
          ValueRequiredForOption raise(unsetOptions join(", ")))
        self
      )

      loadObject := method(name,
        objectName := "iospec reports formatters " .. name asCapitalized
        doMessage(Message fromString(objectName))
      )
    )

    OptionParser := Object clone do (
      init := method(
        newSlot("options", Map clone)
        newSlot("arguments", list)
      )
      
      with := method(argv,
        self clone parse(argv)
      )

      parse := method(argv,
        i := 0
        currentOption := nil
        while (i < argv size,
          if (isStartOfArgumentsMarker(argv at(i))) then (
            arguments = argv slice(i + 1, argv size)
            break
          ) else (if (isOption(argv at(i))) then (
            currentOption := parseOptionName(argv at(i))
            setOption(currentOption, nil)
          ) else (if (currentOption) then (
            setOption(currentOption, argv at(i))
            currentOption := nil
          ) else (
            arguments append(argv at(i))
          )))
          i = i + 1
        )
        self
      )

      isStartOfArgumentsMarker := method(arg,
        arg == "--"
      )

      isOption := method(arg,
        arg beginsWithSeq("--")
      )

      parseOptionName := method(arg,
        name := arg asMutable removePrefix("--")
      )

      setOption := method(option, value,
        options atPut(option, value)
      )
    )

    UnknownOptions := Exception clone
    ValueRequiredForOption := Exception clone
  )
)
