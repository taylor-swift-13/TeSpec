
def precondition(input):
    n = input[0]
    # n must be an integer and non-negative
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    # output must be a string
    if not isinstance(output, str):
        return False
    # for n=0, output should be '0'
    if n == 0:
        return output == '0'
    # split the output and verify it contains numbers 0 to n
    parts = output.split(' ')
    if len(parts) != n + 1:
        return False
    for i in range(n + 1):
        if parts[i] != str(i):
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
