def at_most_two_digitsb(z):
    return abs(z) <= 99

def add_elements_spec(arr, k, res):
    if not (1 <= len(arr) <= 100):
        return False
    if not (1 <= k <= len(arr)):
        return False
    
    filtered_sum = sum(x for x in arr[:k] if at_most_two_digitsb(x))
    return res == filtered_sum

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
