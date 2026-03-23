def count_digits_acc(l, acc):
    e, o = acc
    for h in l:
        if h % 2 == 0:
            e += 1
        else:
            o += 1
    return (e, o)

def to_digits_fuel(fuel, n):
    res = []
    for _ in range(fuel):
        p = abs(n)
        if p == 0:
            break
        res.append(p % 10)
        n = p // 10
    return res

def even_odd_count_impl(num):
    fuel = abs(num) + 1
    l = to_digits_fuel(fuel, num)
    return count_digits_acc(l, (0, 0))

def problem_155_pre(num):
    return True

def problem_155_spec(num, output):
    return output == even_odd_count_impl(num)

def _impl(num):
    even, odd = 0, 0
    for ch in str(num):
        if ch in "02468": even += 1
        if ch in "13579": odd += 1
    return even, odd

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_155_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_155_spec(*input, output))

def even_odd_count(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
