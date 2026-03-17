from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True

def postcondition(input, output):
    string = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(string):
        return False
    for i in range(len(output)):
        if output[i] != string[:i+1]:
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
