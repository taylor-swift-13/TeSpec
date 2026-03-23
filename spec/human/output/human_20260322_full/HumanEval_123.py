def collatz_aux(n, fuel):
    res = []
    curr = n
    for _ in range(fuel):
        if curr == 1:
            res.append(1)
            break
        res.append(curr)
        if curr % 2 == 0:
            curr = curr // 2
        else:
            curr = 3 * curr + 1
    return res

def collatz_list(n, l):
    if not l or l[-1] != 1:
        return False
    # If l is a valid collatz sequence ending in 1, 
    # its length is exactly the minimum fuel required to generate it.
    return collatz_aux(n, len(l)) == l

def problem_123_pre(n):
    return n > 0

def problem_123_spec(n, result):
    if n <= 0:
        # For n <= 0, the sequence never reaches 1, so collatz_list is always False.
        return False
        
    seq = []
    curr = n
    while True:
        seq.append(curr)
        if curr == 1:
            break
        if curr % 2 == 0:
            curr = curr // 2
        else:
            curr = 3 * curr + 1
            
    odds = [x for x in seq if x % 2 != 0]
    expected = sorted(odds)
    
    return result == expected

def _impl(n):
    ans, x = [], n
    while x != 1:
        if x % 2 == 1: ans.append(x)
        x = x // 2 if x % 2 == 0 else x * 3 + 1
    ans.append(1)
    return sorted(ans)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_123_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_123_spec(*input, output))

def get_odd_collatz(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
