import unittest
include "../science/Distributions"
import "../science/Misc"


suite "Distribution specs":
    echo "suite setup: run once before the tests"
    const epsilon = 0.1
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

    test "gamma mean should be correct":
      let shape = 0.9
      let scale = 1.5
      let samples = rgamma(samples, shape, scale)
      let m = mean(samples)
      # mean of gamma is `shape * scale`
      let true_m = shape * scale
      echo(true_m)
      echo(m)
      check((m < true_m + epsilon) and (m > true_m - epsilon)) 

    test "exponential mean must be correct (rate=1.0)":
      let rate = 1.0
      let samples = rexp(samples, rate)
      let m = mean(samples)
      let true_m = 0.99
      check((m < true_m + epsilon) and (m > true_m - epsilon)) 

    test "exponential mean must be correct (rate=0.1)":
      let rate = 0.1
      let samples = rexp(samples, rate)
      let m = mean(samples)
      let true_m = 9.99
      echo(m)
      check((m < true_m + epsilon) and (m > true_m - epsilon)) 