def char_to_digit(c):
    return max(0, ord(c) - ord('0'))

def string_to_nat_aux(s, acc):
    for c in s:
        acc = acc * 10 + char_to_digit(c)
    return acc

def string_to_nat(s):
    return string_to_nat_aux(s, 0)

def parse_fruit_string(s, apples, oranges):
    sep = " apples and "
    suffix = " oranges"

    if not s.endswith(suffix):
        return False

    start = 0
    while True:
        idx = s.find(sep, start)
        if idx == -1:
            break

        if idx + len(sep) <= len(s) - len(suffix):
            s_apples = s[:idx]
            s_oranges = s[idx + len(sep) : len(s) - len(suffix)]

            if string_to_nat(s_apples) == apples and string_to_nat(s_oranges) == oranges:
                return True

        start = idx + 1

    return False

def problem_67_pre(s, n):
    return True

def problem_67_spec(s, n, ret):
    sep = " apples and "
    suffix = " oranges"

    if not s.endswith(suffix):
        return False

    start = 0
    while True:
        idx = s.find(sep, start)
        if idx == -1:
            break

        if idx + len(sep) <= len(s) - len(suffix):
            s_apples = s[:idx]
            s_oranges = s[idx + len(sep) : len(s) - len(suffix)]

            apples = string_to_nat(s_apples)
            oranges = string_to_nat(s_oranges)

            expected = n - (apples + oranges)
            if expected < 0:
                expected = 0

            if ret == expected:
                return True

        start = idx + 1

    return False

def _impl(s, n):
    words = s.split(" ")
    c1, c2 = int(words[0]), int(words[3])
    assert n - c1 - c2 >= 0, "invalid inputs" # $_CONTRACT_$
    return n - c1 - c2

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_67_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_67_spec(*input, output))

def fruit_distribution(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
