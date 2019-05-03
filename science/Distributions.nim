import random
from math import ln, exp, sqrt, pow, tan, PI
from system import abs
import sequtils

proc randn(): float =
  var q, v, u, x, y = 100.0
  while (q > 0.27597 and (q > 0.27846 or v * v > -4 * ln(u) * u * u)):
    u = rand(1.0)
    v = 1.7156 * (rand(1.0) - 0.5)
    x = u - 0.449871
    y = abs(v) + 0.386595
    q = x * x + y * (0.19600 * y - 0.25472 * x)
  return v / u

proc randn(n: int): seq[float] =
  return newSeqWith(n, randn())

proc rnorm*(mean: float, std: float): float =
  return randn() * std + mean

proc rnorm*(n: int, mean: float, std: float): seq[float] =
  return newSeqWith(n, rnorm(mean, std))

proc rpois*(mean: int): int =
  var p = 1.0
  var k = 0
  let L = exp(-float(mean));
  while (p > L):
    inc(k)
    p = p * random(1.0)
  return k - 1

proc rpois*(n: int, mean: int): seq[int] =
  return newSeqWith(n, rpois(mean))

proc rexp*(rate: float): float =
  # rate must be > 0
  return -1.0 / rate * ln(1.0 - rand(1.0))

proc rexp*(n: int, rate: float): seq[float] =
  return newSeqWith(n, rexp(rate))

proc randg(shape: float): float =
  let p = exp(1.0) / (shape + exp(1.0))
  let s = shape - 1.0
  if shape == 1.0:
    return rexp(1.0)
  elif shape > 1.0:
    while true:
        var y = tan(PI * rand(1.0))
        var x = sqrt(2.0 * s) * y + s
        if x <= 0.0:
          continue
        if (rand(1.0) > (1.0 + y * y) * exp((s) * ln(x / s) - sqrt(2.0 * s) * y)):
            continue
        return x
  else:
    while true:
      var u = rand(1.0)
      var y = rexp(1.0)
      var x, q = 0.0
      if u < p:
        x = exp(-y / shape)
        q = p * exp(-x)
      else:
        x = 1.0 + y
        q = p + (1.0 - p) * pow(x, s)
                
      if u >= q:
        continue

      return x

proc rgamma*(shape: float, scale: float): float =
  randg(shape) * scale

proc rgamma*(n: int, shape: float, scale: float): seq[float] =
  return newSeqWith(n, rgamma(shape, scale))

proc runif*() : float = rand(1.0)
proc runif*(n: int): seq[float] = newSeqWith(n, rand(1.0))