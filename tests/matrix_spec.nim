import unittest
import "../science"

suite "Matrix specs":
    echo "suite setup: run once before the tests"
    
    # setup:
    #   echo "run before each test"
    
    # teardown:
    #   echo "run after each test"
    
    test "createMatrix dimensions":
      let m = science.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
      check(m.nrows == 3 and m.ncols == 3)

    test "cloned matrix dimensions":
        let m = science.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
        let m2 = m.clone()
        check(m.isSameSizeAs(m2))
      
    test "zero matrix dimensions":
        let m = science.zeroMatrix(4, 4)
        check(m.nrows == 4 and m.ncols == 4)

    test "adding matrix dimensions":
        let m = science.zeroMatrix(4, 4)
        let m2 = science.zeroMatrix(4, 4)
        let add = m + m2
        check(add.nrows == 4 and add.ncols == 4)

    test "adding matrix values":
        let m = science.createMatrix(@[@[1.0,1.0,1.0], @[2.0,2.0,2.0], @[3.0,3.0,3.0]])
        let a = m + m
        check((a[0,0] == 2.0) and (a[1,1] == 4.0) and (a[2, 2] == 6.0))
        
    test "subtracting matrix dimensions":
        let m = science.zeroMatrix(4, 4)
        let m2 = science.zeroMatrix(4, 4)
        let add = m - m2
        check(add.nrows == 4 and add.ncols == 4)
        

    echo "suite teardown: everything OK?"