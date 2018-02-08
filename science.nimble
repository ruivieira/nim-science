# Package

version       = "0.2.0"
author        = "Rui  Vieira"
description   = "science!"
license       = "Apache 2.0"
skipDirs      = @["examples", "tests"]

# Dependencies

requires "nim >= 0.17.2"

task test, "Runs the test suite":
  exec "nim c -r tests/matrix_spec"

