tmpDir := method(path,
  dir := Directory with(path) do (
    file := method(name,
      self fileNamed(name) create
    )
    cleanup := method(
      self remove
    )
  )
  if (dir exists, dir cleanup)
  dir create
)

