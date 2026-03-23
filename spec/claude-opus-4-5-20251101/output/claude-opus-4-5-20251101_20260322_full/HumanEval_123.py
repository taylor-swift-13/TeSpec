def collatz_next(x):
    if x % 2 == 0:
        return x // 2
    else:
        return x * 3 + 1

def collatz_sequence(x, seq):
    if x <= 0:
        return False
    expected = []
    curr = x
    while curr > 1:
        expected.append(curr)
        curr = collatz_next(curr)
    expected.append(1)
    return expected == seq

def is_odd(x):
    return x % 2 != 0

def filter_odds(l):
    return [x for x in l if is_odd(x)]

def sorted_ascending(l):
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            return False
    return True

def is_permutation(l1, l2):
    return sorted(l1) == sorted(l2)

def get_odd_collatz_spec(n, result):
    if n <= 0:
        return False
    
    expected_seq = []
    curr = n
    while curr > 1:
        expected_seq.append(curr)
        curr = collatz_next(curr)
    expected_seq.append(1)
    
    odds = filter_odds(expected_seq)
    return is_permutation(odds, result) and sorted_ascending(result)

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
