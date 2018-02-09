import unittest
import "../science/Matrix"
import "../science/Vector"
import "../science/Exceptions"
import "../science/Distributions"

suite "Matrix specs":
    echo "suite setup: run once before the tests"
    
    # setup:
    #   echo "run before each test"
    
    # teardown:
    #   echo "run after each test"
    
    test "createMatrix dimensions":
      let m = Matrix.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
      check(m.nrows == 3 and m.ncols == 3)

    test "cloned matrix dimensions":
        let m = Matrix.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
        let m2 = m.clone()
        check(m.isSameSizeAs(m2))
      
    test "zero matrix dimensions":
        let m = Matrix.zeroMatrix(4, 4)
        check(m.nrows == 4 and m.ncols == 4)

    test "random matrix dimensions":
        let m = Matrix.randomMatrix(10, 9)
        check(m.nrows == 10 and m.ncols == 9)
    
    test "adding matrix dimensions":
        let m = Matrix.zeroMatrix(4, 4)
        let m2 = Matrix.zeroMatrix(4, 4)
        let add = m + m2
        check(add.nrows == 4 and add.ncols == 4)

    test "adding matrix values":
        let m = Matrix.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
        let a = m + m
        check((a[0,0] == 2.0) and (a[1,1] == 4.0) and (a[2, 2] == 6.0))

    test "adding invalid dimensions":
        let a = zeroMatrix(5, 6)
        let b = zeroMatrix(3, 7)
        
        expect DimensionError:
            discard a + b
    
    test "subtracting matrix dimensions":
        let m = Matrix.zeroMatrix(4, 4)
        let m2 = Matrix.zeroMatrix(4, 4)
        let add = m - m2
        check(add.nrows == 4 and add.ncols == 4)

    test "subtracting invalid dimensions":
        let a = zeroMatrix(5, 6)
        let b = zeroMatrix(3, 7)
        
        expect DimensionError:
            discard a - b
    
    test "transpose matrix dimensions":
        let m = Matrix.zeroMatrix(4, 3)
        let t = m.transpose()
        check(t.nrows == 3 and t.ncols == 4)
            
    test "transpose matrix elements":
        let m = Matrix.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
        let t = m.transpose()
        check(t[0,0]==1.0 and t[0,1]==2.0 and t[0,2]==3.0)
            
    test "abs() matrix values":
        let m = Matrix.createMatrix(@[@[-1.0,1.0,-1.0], @[2.0,-2.0,2.0], @[3.0,3.0,-3.0]])
        let a = m.abs()
        check(a[0,0]==1.0 and a[0,1]==1.0 and a[0,2]==1.0)
        check(m.nrows == a.nrows and m.ncols == a.ncols)

    test "invalid multiplication":
        let a = zeroMatrix(5, 6)
        let b = zeroMatrix(3, 7)

        expect DimensionError:
            discard a * b

    test "valid multiplication":
        let a = zeroMatrix(5, 6)
        let b = zeroMatrix(6, 5)

        discard a * b
        check(true)

    test "matrix diagonal size":
        let m = Matrix.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
        let d = m.diagonal()

        check(d.len == m.nrows and d.len == m.ncols)
    
    test "matrix diagonal values":
        let m = Matrix.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
        let d = m.diagonal()

        check(d[0]==1.0 and d[1]==2.0 and d[2]==3.0)

    test "matrix fill":
        let m = fillMatrix(5, 5, proc(i: int, j: int): float = rnorm(1.0, 2.0))
        check(m.ncols==5 and m.nrows==5)

    test "matrix entries":
        let m = fillMatrix(5, 5, proc(i: int, j: int): float = rnorm(1.0, 2.0))
        let e = m.entries()
        check(e.len == 25)
    
    echo "suite teardown: everything OK?"