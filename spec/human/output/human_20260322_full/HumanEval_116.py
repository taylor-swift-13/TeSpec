def count_ones_helper(n, fuel):
    res = 0
    for _ in range(fuel):
        if n == 0:
            break
        res += n % 2
        n //= 2
    return res

def count_ones(n):
    return count_ones_helper(n, n)

def lt_custom(a, b):
    ones_a = count_ones(a)
    ones_b = count_ones(b)
    return (ones_a < ones_b) or (ones_a == ones_b and a < b)

def lt_custom_bool(a, b):
    ones_a = count_ones(a)
    ones_b = count_ones(b)
    if ones_a < ones_b:
        return True
    elif ones_a == ones_b:
        return a < b
    else:
        return False

def insert_sorted(x, l):
    for i, h in enumerate(l):
        if lt_custom_bool(x, h):
            return l[:i] + [x] + l[i:]
    return l + [x]

def sort_array_impl(input):
    res = []
    for h in reversed(input):
        res = insert_sorted(h, res)
    return res

def problem_116_pre(input):
    return True

def problem_116_spec(input, output):
    return output == sort_array_impl(input)

def _impl(arr):
    from functools import cmp_to_key
    def cmp(x: int, y: int) -> int:
        x1 = len(list(filter(lambda ch: ch == "1", bin(x))))
        y1 = len(list(filter(lambda ch: ch == "1", bin(y))))
        if x1 != y1: return x1 - y1
        return x - y
    return sorted(arr, key=cmp_to_key(cmp))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_116_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_116_spec(*input, output))

def sort_array(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
