tmpDir := method(path,
  Directory with(path) do (
    file := method(name,
      self fileNamed(name) create
    )
    cleanup := method(
      self remove
    )
  ) createIfAbsent
)

