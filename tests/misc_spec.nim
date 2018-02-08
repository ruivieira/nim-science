import unittest
import "../science/Misc"
import "../science/Distributions"

suite "Misc specs":
    echo "suite setup: run once before the tests"
    
    # setup:
    #   echo "run before each test"
    
    # teardown:
    #   echo "run after each test"
    
    test "variance":
      check(variance(@[1.0, 2.0, 3.0, 4.0]) == 1.25)
