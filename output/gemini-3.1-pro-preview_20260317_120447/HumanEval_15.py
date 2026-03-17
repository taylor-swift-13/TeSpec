
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n >= 0

def postcondition(args, output):
    n = args[0]
    if not isinstance(output, str):
        return False
    return output == ' '.join(str(i) for i in range(n + 1))

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
