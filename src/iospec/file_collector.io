FileCollector := Object clone do (
  newSlot("directory")

  collect := method(pattern,
    fnmatch := fnmatch(if (pattern, pattern, "*"))
    iofiles := Directory with(directory) recursiveFilesOfTypes(list(".io"))
    matched := iofiles select(file, fnmatch matchFor(file name))
    matched map(path)
  )

  fnmatch := method(pattern,
    Fnmatch clone setPattern(pattern)
  )
)

