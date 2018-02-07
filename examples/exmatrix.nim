import science
import strutils

when isMainModule:
    let m = science.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])

    echo(repr(m))

    echo(repr(m.row(1)))

    echo(repr(m.col(1)))

    echo("matrix has $# rows and $# columns." % [$m.nrows(), $m.ncols()])

    let m2 = m.clone()

    if m.isSameSizeAs(m2):
        echo("They have both the same size")

    echo(repr(m.dimensions()))

    let z = science.zeroMatrix(4, 4)

    echo(repr(z))

    echo("transpose matrix")

    let t = m.transpose()

    echo(repr(t))

    echo("Add the two matrices")

    let add = m + m2

    echo(repr(add))

    let v = science.randomVector(10)

    echo(repr(v))

    let zeros = science.zeroVector(10)

    echo(repr(zeros))

    echo("dot product:")

    let a = science.randomVector(10)
    let b = science.randomVector(10)

    echo(repr(a))
    echo(repr(b))

    echo(repr(a.dot(b)))

    echo("Modulus:")

    echo(repr(modulus(a)))

    echo("Normalize:")

    let norm = normalise(a)
    echo(repr(norm))
    echo(repr(modulus(norm)))