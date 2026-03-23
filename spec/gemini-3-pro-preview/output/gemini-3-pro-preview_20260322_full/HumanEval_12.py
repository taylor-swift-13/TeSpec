from typing import List, Optional

def longest_spec(strings, result):
    if not strings:
        return result is None
    
    longest = strings[0]
    for s in strings[1:]:
        if len(s) > len(longest):
            longest = s
            
    return result == longest

def _impl(strings: List[str]) -> Optional[str]:
    if not strings:
        return None
    maxlen = max(len(x) for x in strings)
    for s in strings:
        if len(s) == maxlen:
            return s

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(longest_spec(*input, output))

def longest(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
