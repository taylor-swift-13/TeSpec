
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    n = input[0]
    parts = output.split(' ')
    if len(parts) != n + 1:
        return False
    for i, part in enumerate(parts):
        try:
            if int(part) != i:
                return False
        except ValueError:
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
