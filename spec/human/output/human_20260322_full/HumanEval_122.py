def is_at_most_two_digits(n: int) -> bool:
    return -100 < n < 100

def problem_122_pre(arr: list, k: int) -> bool:
    return 1 <= len(arr) <= 100 and 1 <= k <= len(arr)

def problem_122_spec(arr: list, k: int, result: int) -> bool:
    first_k_elements = arr[:k]
    filtered_elements = [x for x in first_k_elements if is_at_most_two_digits(x)]
    return result == sum(filtered_elements)

def _impl(arr, k):
    def digits(x: int) -> int:
        s = str(x)
        return len(s) - 1 if s[0] == "-" else len(s)
    return sum(filter(lambda x: digits(x) <= 2, arr[:k]))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_122_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_122_spec(*input, output))

def add_elements(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
