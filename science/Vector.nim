import sequtils
import random
from Math import sqrt

type
    Vector* = ref object of RootObj
        elements: seq[float]

proc `[]`*(vector: Vector, i: int): float {.noSideEffect.} =
    return vector.elements[i]

proc `[]=`*(vector: Vector, i: int, value: float): void =
    vector.elements[i] = value

proc len*(vector: Vector): int {.noSideEffect.} =
    return vector.elements.len
    
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