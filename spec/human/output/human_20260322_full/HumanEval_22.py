from typing import List, Any

class PyInt:
    def __init__(self, n):
        self.n = n
        
    def __eq__(self, other):
        return isinstance(other, PyInt) and self.n == other.n

class PyString:
    def __init__(self, s):
        self.s = s
        
    def __eq__(self, other):
        return isinstance(other, PyString) and self.s == other.s

class PyFloat:
    def __eq__(self, other):
        return isinstance(other, PyFloat)

class PyDict:
    def __eq__(self, other):
        return isinstance(other, PyDict)

class PyList:
    def __eq__(self, other):
        return isinstance(other, PyList)

def is_int(v):
    return isinstance(v, PyInt)

def is_subsequence(l1, l2):
    it = iter(l2)
    for x in l1:
        for y in it:
            if x == y:
                break
        else:
            return False
    return True

def problem_22_pre(input):
    return True

def problem_22_spec(input, output):
    # 1. Ensure output is a subsequence of input.
    if not is_subsequence(output, input):
        return False
    
    # 2. Core filtering logic:
    # A value v is in output if and only if it is in input and it is an integer.
    # We check this condition for all elements present in either input or output.
    elements = input + output
    for v in elements:
        in_out = v in output
        in_in = v in input
        is_i = is_int(v)
        
        if in_out != (in_in and is_i):
            return False
            
    return True

def _impl(values: List[Any]) -> List[int]:
    return list(filter(lambda x: type(x) == int, values))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_22_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_22_spec(*input, output))

def filter_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
