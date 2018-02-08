import unittest
include "../science/Distributions"
import "../science/Misc"


suite "Distribution specs":
    echo "suite setup: run once before the tests"
    const epsilon = 0.01
    const samples = 1000000
    
    test "randn size":
      let a = randn(10)
      check(a.len == 10)

    test "randn mean":
      let a = randn(samples)
      let m = mean(a)
      check((m < 0.0 + epsilon) and (m > 0.0 - epsilon))

    test "rnorm mean":
      let a = mean(rnorm(samples, 25.0, 5.0))
      check((a < 25.0 + epsilon) and (a > 25.0 - epsilon))

    test "rnorm standard deviation":
      let a = sd(rnorm(samples, 25.0, 5.0))
      check((a < 5.0 + epsilon) and (a > 5.0 - epsilon))    