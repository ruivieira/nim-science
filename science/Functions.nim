import math

func squared_distance*(x: seq[float], y: seq[float]): float =
    var sum = 0.0
    for i in 0..<len(x):
        sum += (x[i]-y[i]).pow(2.0)
    return sum