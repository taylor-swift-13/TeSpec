
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # reject booleans (subclass of int) and require an integer >= 0
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    if not isinstance(output, str):
        return False
    # split on single space and ensure no empty tokens (catches extra/leading/trailing/multiple spaces)
    parts = output.split(' ')
    if any(p == '' for p in parts):
        return False
    if len(parts) != n + 1:
        return False
    for i, p in enumerate(parts):
        if p != str(i):
            return False
    return True

def _impl(n: int) -> str:
    """Return a string containing space-delimited numbers starting from 0 upto n inclusive.
    '0'
    '0 1 2 3 4 5'"""
    return " ".join(map(str, range(n + 1)))

def string_sequence(n: int) -> str:
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
