import random
from math import ln
from system import abs
import sequtils

proc randn(): float =
  var q, v, u, x, y = 100.0
  while (q > 0.27597 and (q > 0.27846 or v * v > -4 * ln(u) * u * u)):
    u = random(1.0)
    v = 1.7156 * (random(1.0) - 0.5)
    x = u - 0.449871
    y = abs(v) + 0.386595
    q = x * x + y * (0.19600 * y - 0.25472 * x)
  return v / u

proc randn(n: int): seq[float] =
  return newSeqWith(n, randn())


proc rnorm(mean: float, std: float): float =
  return randn() * std + mean

proc rnorm(n: int, mean: float, std: float): seq[float] =
  return newSeqWith(n, rnorm(mean, std))