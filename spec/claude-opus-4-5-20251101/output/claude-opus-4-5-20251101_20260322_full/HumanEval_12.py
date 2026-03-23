from typing import List, Optional

def string_length(s):
    return len(s)

def max_length(strings):
    if not strings:
        return 0
    return max(string_length(s) for s in strings)

def find_first_with_length(strings, length):
    for s in strings:
        if string_length(s) == length:
            return s
    return None

def longest_spec(strings, result):
    if not strings:
        return result is None
    
    maxlen = max_length(strings)
    
    if result is None:
        return False
        
    s = result
    if s not in strings:
        return False
    if string_length(s) != maxlen:
        return False
        
    # Check the condition:
    # forall s'' idx1 idx2, In s'' strings -> string_length s'' = maxlen ->
    # nth_error strings idx1 = Some s -> nth_error strings idx2 = Some s'' -> idx1 <= idx2
    idx1_list = [i for i, x in enumerate(strings) if x == s]
    idx2_list = [i for i, x in enumerate(strings) if string_length(x) == maxlen]
    
    for idx1 in idx1_list:
        for idx2 in idx2_list:
            if not (idx1 <= idx2):
                return False
                
    return True

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
