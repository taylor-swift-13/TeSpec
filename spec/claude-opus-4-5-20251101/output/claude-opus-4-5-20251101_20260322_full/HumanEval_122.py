def digits(x: int) -> int:
    abs_x = abs(x)
    if abs_x < 10:
        return 1
    elif abs_x < 100:
        return 2
    elif abs_x < 1000:
        return 3
    elif abs_x < 10000:
        return 4
    else:
        return 5

def has_at_most_two_digits(x: int) -> bool:
    return digits(x) <= 2

def firstn_Z(n: int, l: list) -> list:
    return l[:n]

def filter_sum(f, l: list) -> int:
    return sum(x for x in l if f(x))

def add_elements_spec(arr: list, k: int, result: int) -> bool:
    return result == filter_sum(has_at_most_two_digits, firstn_Z(k, arr))

def _impl(arr, k):
    def digits(x: int) -> int:
        s = str(x)
        return len(s) - 1 if s[0] == "-" else len(s)
    return sum(filter(lambda x: digits(x) <= 2, arr[:k]))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(add_elements_spec(*input, output))

def add_elements(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
