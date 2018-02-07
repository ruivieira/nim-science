import sequtils
import random
import Math

type 
    Matrix* = ref object of RootObj
        elements: seq[seq[float]]

proc setElements(matrix: Matrix, elements: seq[seq[float]]): Matrix =
    matrix.elements = elements
    return matrix

proc createMatrix*(elements: seq[seq[float]]): Matrix =
    let matrix = Matrix.new()
    matrix.setElements(elements)

proc zeroMatrix*(rows: int, cols: int): Matrix = 
    let matrix = Matrix.new()
    return matrix.setElements(newSeqWith(rows, newSeq[float](cols)))

proc nrows*(matrix: Matrix): int =
    return matrix.elements.len

proc ncols*(matrix: Matrix): int =
    return matrix.elements[0].len

proc clone*(matrix: Matrix): Matrix =
    let elements = matrix.elements
    return createMatrix(elements)

proc isSameSizeAs*(matrix: Matrix, other: Matrix): bool =
    return (matrix.elements.len == other.elements.len and matrix.elements[0].len == other.elements[0].len)

proc dimensions*(matrix: Matrix): (int, int) =
    return (matrix.nrows, matrix.ncols)

# proc `+`*(matrix: Matrix, other: Matrix): Matrix =

type
    Vector* = ref object of RootObj
        elements: seq[float]


proc setElements(vector: Vector, elements: seq[float]): Vector =
    vector.elements = elements
    return vector

proc createVector*(elements: seq[float]): Vector =
    let vector = Vector.new()
    vector.setElements(elements)

proc randomVector*(n: int): Vector =
    let elements: seq[float] = newSeqWith(n, random(1.0))
    return createVector(elements)

proc zeroVector*(n: int): Vector =
    let elements: seq[float] = newSeqWith(n, 0.0)
    return createVector(elements)

proc dot*(vector: Vector, other: Vector): float =
    let n = vector.elements.len
    # TODO: sanity check, other len must be the same
    var product = 0.0
    for i in countup(0, n-1):
        product += vector.elements[i] * other.elements[i]
    return product

proc modulus*(vector: Vector): float =
    return sqrt(vector.dot(vector))

proc normalise*(vector: Vector): Vector =
    let r = modulus(vector)
    let norm = map(vector.elements, proc (x: float): float = x / r)
    return createVector(norm)

proc row*(matrix: Matrix, i: int): Vector =
    return createVector(matrix.elements[i])
    
proc col*(matrix: Matrix, i: int): Vector =
    return createVector(map(matrix.elements, proc (x: seq[float]): float = x[i]))