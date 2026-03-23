def collatz_next(n: int) -> int:
    if n % 2 == 0:
        return n // 2
    else:
        return 3 * n + 1

def get_odd_collatz_spec(n: int, l: list) -> bool:
    seq = []
    seen = set()
    curr = n
    
    # Compute the Collatz sequence reachable from n
    while True:
        if curr in seen:
            break
        seq.append(curr)
        seen.add(curr)
        if curr == 1:
            break
        curr = collatz_next(curr)
    
    # Filter for odd numbers
    expected_odds = set(x for x in seq if x % 2 != 0)
    
    # Check if l is sorted in ascending order
    is_sorted = all(l[i] <= l[i+1] for i in range(len(l) - 1))
    if not is_sorted:
        return False
        
    # Check if l contains exactly the expected odd numbers
    return set(l) == expected_odds

def _impl(n):
    ans, x = [], n
    while x != 1:
        if x % 2 == 1: ans.append(x)
        x = x // 2 if x % 2 == 0 else x * 3 + 1
    ans.append(1)
    return sorted(ans)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(get_odd_collatz_spec(*input, output))

def get_odd_collatz(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
