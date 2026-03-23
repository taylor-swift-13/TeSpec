import math

def sum_list(l):
    return sum(l)

def ceil_div(n, d):
    if d == 0:
        return 0
    return (n + d - 1) // d

def max_fill_spec(grid, capacity, ans):
    for row in grid:
        for x in row:
            if x != 0 and x != 1:
                return False
                
    if not (1 <= capacity <= 10):
        return False
        
    if not (1 <= len(grid) <= 100):
        return False
        
    for r1 in grid:
        for r2 in grid:
            if len(r1) != len(r2):
                return False
                
    for row in grid:
        if not (1 <= len(row) <= 100):
            return False
            
    expected_ans = 0
    for row in grid:
        expected_ans += ceil_div(sum_list(row), capacity)
        
    return ans == expected_ans

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
