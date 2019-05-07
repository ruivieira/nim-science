import science/Distributions
import strutils
from math import sqrt

proc gibbs(n: int, thin: int) =
    var x = 0.0
    var y = 0.0
    echo("Iter  x  y")
    for i in 0..n:
        for j in 0..thin:
            x = rgamma(3.0, y*y+4.0)
            y = rnorm(1.0/(x+1.0), 1.0/sqrt(2.0*x+2.0))
        echo("$1 $2 $3" % @[$i, $x, $y])

when isMainModule: 
    gibbs(50000, 1000)