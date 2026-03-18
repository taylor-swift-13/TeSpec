from typing import List

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, str) for x in output):
        return False
    expected = [s[:i] for i in range(1, len(s) + 1)]
    return output == expected

def _impl(string: str) -> List[str]:
    """
    Return list of all prefixes from shortest to longest of the input string
    ['a', 'ab', 'abc']
    """
    return [string[:(i + 1)] for i in range(len(string))]

def all_prefixes(string: str) -> List[str]:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
