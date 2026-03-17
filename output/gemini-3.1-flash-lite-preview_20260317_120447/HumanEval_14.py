from typing import List

def precondition(input):
    return isinstance(input[0], str)

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(s):
        return False
    for i in range(len(s)):
        if output[i] != s[:i+1]:
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
