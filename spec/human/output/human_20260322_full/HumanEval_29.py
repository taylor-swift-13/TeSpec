from typing import List

def is_subsequence(l1, l2):
    it = iter(l2)
    for x in l1:
        for y in it:
            if x == y:
                break
        else:
            return False
    return True

def problem_29_pre(input):
    return True

def problem_29_spec(input, substring, output):
    # 1. output is a subsequence of input
    if not is_subsequence(output, input):
        return False
    
    # 2. A string s is in output iff it is in input and has the given prefix.
    # We only need to check strings that are present in either input or output.
    for s in set(input + output):
        in_output = s in output
        in_input = s in input
        has_prefix = s.startswith(substring)
        
        if in_output != (in_input and has_prefix):
            return False
            
    return True

def _impl(strings: List[str], prefix: str) -> List[str]:
    return list(filter(lambda x: x.startswith(prefix), strings))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_29_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_29_spec(*input, output))

def filter_by_prefix(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
