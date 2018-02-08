from math import sum, sqrt

proc mean*(values: seq[float]): float =
  return sum(values) / float(values.len)

# sum of squared errors of prediction (SSE)
proc sumsqerr*(values: seq[float]): float =
  let valuesMean = mean(values)
  var tSum = 0.0
  var i = values.len - 1
  var tmp = 0.0
  while i >= 0:
    tmp = values[i] - valuesMean
    tSum += tmp * tmp
    dec(i)
  return tSum

# variance of a sequence
proc variance*(values: seq[float], population: bool = true): float =
  let correct = if population: 0.0
    else: 1.0
  return sumsqerr(values) / (float(values.len) - correct)

# standard deviation of a seq
proc sd*(values: seq[float]): float =
  return sqrt(variance(values))