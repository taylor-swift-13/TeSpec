from typing import List

def precondition(input) -> bool:
    # input should be a tuple with a single string argument
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output) -> bool:
    # input is the same as in precondition
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    # output must be a list of prefixes from shortest to longest
    if not isinstance(output, list):
        return False
    if len(output) != len(s):
        return False
    for i in range(len(s)):
        if not isinstance(output[i], str):
            return False
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
