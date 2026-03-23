from typing import List, Union, Tuple, Optional

def problem_68_pre(arr: List[int]) -> bool:
    return True

def problem_68_spec(arr: List[int], output: Union[List[int], Tuple[int, int], None]) -> bool:
    # Normalize output to match Coq's option (nat * nat)
    # Python representation: None or [] for None; [v, i] or (v, i) for Some (v, i)
    normalized_output = None
    if output is None:
        normalized_output = None
    elif isinstance(output, list):
        if len(output) == 0:
            normalized_output = None
        elif len(output) == 2:
            normalized_output = (output[0], output[1])
        else:
            return False
    elif isinstance(output, tuple):
        if len(output) == 2:
            normalized_output = output
        else:
            return False
    else:
        return False

    if normalized_output is None:
        # Case 1: Output is None (or [])
        # Coq: forall val, In val arr -> Nat.even val = false
        # Meaning: No even numbers in arr
        for val in arr:
            if val % 2 == 0:
                return False
        return True
    else:
        v, i = normalized_output
        
        # Case 2: Output is Some (v, i)
        
        # 1. i < length arr /\ nth i arr 1 = v
        if not (0 <= i < len(arr)):
            return False
        if arr[i] != v:
            return False
            
        # 2. Nat.even v = true
        if v % 2 != 0:
            return False
            
        # 3. (forall val, In val arr -> Nat.even val = true -> v <= val)
        # Meaning: v is the smallest even value in arr
        for val in arr:
            if val % 2 == 0:
                if v > val:
                    return False
                    
        # 4. (forall j, j < i -> nth j arr 1 <> v)
        # Meaning: v does not appear at any index j < i (i is the first occurrence of v)
        for j in range(i):
            if arr[j] == v:
                return False
                
        return True

def _impl(arr):
    if all(val % 2 == 1 for val in arr): return []
    min_even = min(filter(lambda x: x % 2 == 0, arr))
    for i in range(len(arr)):
        if arr[i] == min_even:
            return [min_even, i]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_68_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_68_spec(*input, output))

def pluck(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
