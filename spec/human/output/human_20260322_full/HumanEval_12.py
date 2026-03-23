from typing import List, Optional

def problem_12_pre(input):
    return True

def problem_12_spec(input, output):
    if len(input) == 0:
        return output is None
    
    if output is None:
        return False
        
    expected = input[0]
    for s in input[1:]:
        if len(s) > len(expected):
            expected = s
            
    return output == expected

def _impl(strings: List[str]) -> Optional[str]:
    if not strings:
        return None
    maxlen = max(len(x) for x in strings)
    for s in strings:
        if len(s) == maxlen:
            return s

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_12_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_12_spec(*input, output))

def longest(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
