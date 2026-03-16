
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n >= 0

def postcondition(args, result):
    n = args[0]
    if not isinstance(result, str):
        return False
    if n == 0:
        return result == "0"
    expected_parts = [str(i) for i in range(n + 1)]
    expected = " ".join(expected_parts)
    return result == expected

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
