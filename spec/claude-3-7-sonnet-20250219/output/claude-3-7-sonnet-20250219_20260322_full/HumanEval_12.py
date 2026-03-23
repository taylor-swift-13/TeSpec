from typing import List, Optional

def longest_spec(strings, result):
    # Match empty list and None
    if not strings:
        return result is None
    
    # If strings is not empty but result is None, it's only valid if strings was empty
    if result is None:
        return len(strings) == 0
    
    s = result
    
    # In s strings
    if s not in strings:
        return False
        
    # (forall s', In s' strings -> String.length s' <= String.length s)
    max_len = max(len(x) for x in strings)
    if len(s) < max_len:
        return False
        
    # The third condition in Coq is:
    # forall prefix, In prefix strings -> String.length prefix = String.length s -> s = prefix \/ 
    #   (exists after prefix', strings = prefix :: after /\ prefix' = s /\ In prefix after -> False)
    #
    # Due to Coq's precedence rules, `A /\ B /\ C -> False` parses as `(A /\ B /\ C) -> False`.
    # Since `prefix'` is existentially quantified over strings, we can always choose a `prefix'` 
    # that is not equal to `s` (e.g., prefix' = s + "_"). 
    # This makes `prefix' = s` False, which makes the premise of the implication False, 
    # and thus the implication itself True.
    # Therefore, the `exists` clause is unconditionally True in Coq for all concrete inputs.
    # As a result, the entire `forall prefix` condition is trivially satisfied.
    
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
