import math

def sum_list(l):
    return sum(l)

def ceil_div(a, b):
    return (a + b - 1) // b

def max_fill_spec(grid, capacity, result):
    if capacity <= 0:
        return False
    
    for row in grid:
        for x in row:
            if x != 0 and x != 1:
                return False
                
    expected_result = 0
    for row in grid:
        expected_result += ceil_div(sum_list(row), capacity)
        
    return result == expected_result

def _impl(grid, capacity):
    ans = 0
    for l in grid:
        ans += math.ceil(sum(l) / capacity)
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(max_fill_spec(*input, output))

def max_fill(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
