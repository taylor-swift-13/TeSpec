def count(z, lst):
    res = 0
    for h in lst:
        if z == h:
            res += 1
    return res

def find_max_satisfying(lst, candidates, current_max):
    for h in candidates:
        if count(h, lst) >= h:
            current_max = max(h, current_max)
    return current_max

def search_impl(lst):
    if not lst:
        return -1
    candidates = lst
    max_val = find_max_satisfying(lst, candidates, -1)
    if max_val == -1:
        return -1
    else:
        return max_val

def problem_69_pre(lst):
    if not lst:
        return False
    for x in lst:
        if x <= 0:
            return False
    return True

def problem_69_spec(lst, y):
    return y == search_impl(lst)

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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_69_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_69_spec(*input, output))

def search(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
