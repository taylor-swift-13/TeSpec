
def precondition(input):
    # input should be a tuple of length 1 containing an int n
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    return isinstance(n, int)

def postcondition(input, output):
    # output should be a string: numbers from 0 to n inclusive, space-separated
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if not isinstance(output, str):
        return False
    expected = ' '.join(str(i) for i in range(n + 1))
    return output == expected

def _impl(n: int) -> str:
    """
    Return a string containing space-delimited numbers starting from 0 upto n inclusive.
    '0'
    '0 1 2 3 4 5'
    """
    return " ".join(map(str, range(n + 1)))

def string_sequence(n: int) -> str:
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
