from typing import List

def precondition(args):
    if len(args) != 1:
        return False
    if not isinstance(args[0], str):
        return False
    return True

def postcondition(args, output):
    if len(args) != 1:
        return False
    string = args[0]
    if not isinstance(output, list):
        return False
    if len(output) not in (len(string), len(string) + 1):
        return False
    for item in output:
        if not isinstance(item, str):
            return False
        if not string.startswith(item):
            return False
    for i in range(1, len(output)):
        if len(output[i]) <= len(output[i-1]):
            return False
    if output and output[-1] != string:
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
