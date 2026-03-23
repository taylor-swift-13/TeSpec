def largest_divisor_spec(n: int, result: int) -> bool:
    if n <= 1:
        return result == 1
    else:
        if not (result >= 1 and result < n and n % result == 0):
            return False
        
        # Check the forall condition: forall d : Z, d > result -> d < n -> ...
        for d in range(result + 1, n):
            cond1 = (n % d != 0)
            
            # Calculate d * (n / d) <> n / (n / d)
            # In Coq, division by zero returns 0, though here d < n implies n // d >= 1
            nd = n // d
            if nd == 0:
                val2 = 0
            else:
                val2 = n // nd
                
            cond2 = (d * nd != val2)
            
            if not (cond1 or cond2):
                return False
                
        return True

def _impl(n: int) -> int:
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(largest_divisor_spec(*input, output))

def largest_divisor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
