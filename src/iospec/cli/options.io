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
    checkForUnknownOptions(options)

    options keys foreach(opt,
      if (options hasKey(opt),
        value := loadObject(options at(opt))
        self setSlot(opt, value))
    )
    self
  )

  checkForUnknownOptions := method(options,
    unknownOptions := options keys difference(optionNames)
    if (unknownOptions size > 0,
      UnknownOptions raise(unknownOptions join(", ")))
    self
  )

  loadObject := method(name,
    objectName := name asCapitalized
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
    arg asMutable removePrefix("--")
  )

  setOption := method(option, value,
    options atPut(option, value)
  )
)

UnknownOptions := Exception clone
