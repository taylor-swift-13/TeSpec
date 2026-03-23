from typing import List

def all_prefixes_spec(s, res):
    expected = [s[:i+1] for i in range(len(s))]
    return res == expected

def _impl(string: str) -> List[str]:
    return [string[:(i + 1)] for i in range(len(string))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(all_prefixes_spec(*input, output))

def all_prefixes(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
