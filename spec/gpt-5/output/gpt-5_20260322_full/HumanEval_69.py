def freq(z, l):
    return sum(1 for x in l if x == z)

def search_spec(lst, ans):
    if not all(x > 0 for x in lst):
        return False
    if not lst:
        return False
    
    valid_ns = [n for n in set(lst) if n > 0 and freq(n, lst) >= n]
    
    if valid_ns:
        return ans == max(valid_ns)
    else:
        return ans == -1

def _impl(lst):
    count = dict()
    for num in lst:
        if num not in count:
            count[num] = 0
        count[num] += 1
    ans = -1
    for num, cnt in count.items():
        if cnt >= num:
            ans = max(ans, num)
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(search_spec(*input, output))

def search(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
