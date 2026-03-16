from typing import List

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
    if not isinstance(output, list):
        return False
    if len(output) != len(s):
        return False
    for i in range(len(s)):
        item = output[i]
        if not isinstance(item, str):
            return False
        if item != s[: i + 1]:
            return False
    return True

def _impl(string: str) -> List[str]:
    """Return list of all prefixes from shortest to longest of the input string
    ['a', 'ab', 'abc']"""
    return [string[:(i + 1)] for i in range(len(string))]

def all_prefixes(string: str) -> List[str]:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
