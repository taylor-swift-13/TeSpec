def add_elements_spec(arr, k, result):
    k_nat = max(0, int(k))
    first_k = arr[:k_nat]
    filtered = [x for x in first_k if abs(x) < 100]
    return result == sum(filtered)

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
