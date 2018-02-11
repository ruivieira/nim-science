import sequtils
import random
import Exceptions
import Vector

type 
    Matrix* = ref object of RootObj
        elements: seq[seq[float]]

    MatrixEntry* = ref object of RootObj
        row*: int
        col*: int
        value*: float

proc `[]`*(matrix: Matrix, i: int, j: int): float {.noSideEffect.} =
    return matrix.elements[i][j]

proc `[]=`*(matrix: Matrix, i: int, j: int, value: float): void =
    matrix.elements[i][j] = value    
    
proc setElements(matrix: Matrix, elements: seq[seq[float]]): Matrix =
    matrix.elements = elements
    return matrix

proc createMatrix*(elements: seq[seq[float]]): Matrix =
    let matrix = Matrix.new()
    matrix.setElements(elements)

proc zeroMatrix*(rows: int, cols: int): Matrix = 
    let matrix = Matrix.new()
    return matrix.setElements(newSeqWith(rows, newSeq[float](cols)))

proc randomMatrix*(rows: int, cols: int): Matrix =
    let r = zeroMatrix(rows, cols)
    for i in 0..<rows:
        for j in 0..<cols:
            r[i,j] = random(1.0)
    return r

proc nrows*(matrix: Matrix): int {.noSideEffect.} =
    return matrix.elements.len

proc ncols*(matrix: Matrix): int {.noSideEffect.} =
    return matrix.elements[0].len

proc transpose*(matrix: Matrix): Matrix =
    let nrows = matrix.nrows
    let ncols = matrix.ncols
    let t = zeroMatrix(ncols, nrows)
    for i in 0..<ncols:
        for j in 0..<nrows:
            t[i, j] = matrix[j, i]
    return t    

proc clone*(matrix: Matrix): Matrix =
    let elements = matrix.elements
    return createMatrix(elements)

proc isSameSizeAs*(matrix: Matrix, other: Matrix): bool {.noSideEffect.} =
    return (matrix.elements.len == other.elements.len and matrix.elements[0].len == other.elements[0].len)

proc canMultiplyFromLeft(matrix: Matrix, other: Matrix): bool {.noSideEffect.} =
    return (matrix.ncols == other.nrows)

proc sameSize(matrix: Matrix, other: Matrix): bool {.noSideEffect.} =
    return (matrix.nrows == other.nrows) and (matrix.ncols == other.ncols)

proc isSquare(matrix: Matrix): bool {.noSideEffect.} =
    return (matrix.nrows == matrix.ncols)

proc dimensions*(matrix: Matrix): (int, int) {.noSideEffect.} =
    return (matrix.nrows, matrix.ncols)

proc `+`*(matrix: Matrix, other: Matrix): Matrix =
    if not matrix.sameSize(other):
        raise newException(DimensionError, "Matrix dimensions do not agree")

    let rows = matrix.nrows
    let cols = matrix.ncols
    let output = zeroMatrix(rows, cols)
    for i in 0..<rows:
        for j in 0..<cols:
            output[i,j] = matrix[i,j] + other[i,j]
    return output

proc `-`*(matrix: Matrix, other: Matrix): Matrix =
    if not matrix.sameSize(other):
        raise newException(DimensionError, "Matrix dimensions do not agree")

    let rows = matrix.nrows
    let cols = matrix.ncols
    let output = zeroMatrix(rows, cols)
    for i in 0..<rows:
        for j in 0..<cols:
            output[i,j] = matrix[i,j] - other[i,j]
    return output
    
proc `*`*(matrix: Matrix, other: Matrix): Matrix =
    if not matrix.canMultiplyFromLeft(other):
        raise newException(DimensionError, "Matrix dimensions do not agree")

    let aRows = matrix.nrows
    let aCols = matrix.ncols
    let bCols = other.ncols

    let c = zeroMatrix(aRows, bCols)

    for i in 0..<aRows:
        for j in 0..<bCols:
            for k in 0..<aCols:
                c[i,j] = c[i,j] + matrix[i, k] * other[k, j]
    return c

proc map*(matrix: Matrix, f: proc(x:float, i, j: int):float): Matrix =
    let rows = matrix.nrows
    let cols = matrix.ncols
    let output = zeroMatrix(rows, cols)
    for i in 0..<rows:
        for j in 0..<cols:
            output[i,j] = f(matrix[i,j], i, j)
    return output

proc abs*(matrix: Matrix): Matrix =
    return matrix.map(proc(x: float, i: int, j: int):float = abs(x))

proc row*(matrix: Matrix, i: int): Vector =
    return createVector(matrix.elements[i])
    
proc col*(matrix: Matrix, i: int): Vector =
    return createVector(map(matrix.elements, proc (x: seq[float]): float = x[i]))

proc diagonal*(matrix: Matrix): Vector = 
    if not matrix.isSquare:
        raise newException(DimensionError, "Matrix is not square")

    let rows = matrix.nrows
    let diag = zeroVector(rows)
    for i in 0..<rows:
        diag[i] = matrix[i,i]
    
    return diag

proc fillMatrix*(i: int, j: int, fill: proc(i: int, j: int): float): Matrix =
    let matrix = zeroMatrix(i, j)
    return matrix.map(proc(x: float, i: int, j: int):float = fill(i, j))

proc entries*(matrix: Matrix): seq[MatrixEntry] =
    let nrows = matrix.nrows
    let ncols = matrix.ncols
    var output: seq[MatrixEntry] = @[]
    for i in 0..<nrows:
        for j in 0..<ncols:
            output.add(MatrixEntry(row: i, col: j, value: matrix[i,j]))
    return output

proc elements*(matrix: Matrix): seq[seq[float]] =
    return matrix.elements

