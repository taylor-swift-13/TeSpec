
import numbers

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not precondition(input):
        return False
    s = input[0]
    try:
        folded = s.casefold()
    except Exception:
        # If casefold unexpectedly fails, consider postcondition violated
        return False
    expected = len(set(folded))
    if not isinstance(output, numbers.Integral):
        return False
    if isinstance(output, bool):
        return False
    return int(output) == expected

def _impl(string: str) -> int:
    """Given a string, find out how many distinct characters (regardless of case) does it consist of
    3
    4"""
    return len(set(string.lower()))

def count_distinct_characters(string: str) -> int:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
