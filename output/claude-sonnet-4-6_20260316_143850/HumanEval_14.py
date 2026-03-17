from typing import List

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    string = input[0]
    return isinstance(string, str)

def postcondition(input, output) -> bool:
    string = input[0]
    if not isinstance(output, list):
        return False
    if len(string) == 0:
        return len(output) == 0
    if len(output) != len(string):
        return False
    for i, prefix in enumerate(output):
        if not isinstance(prefix, str):
            return False
        if prefix != string[:i+1]:
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
