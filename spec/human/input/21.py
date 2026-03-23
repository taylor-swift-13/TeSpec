from typing import List

def is_list_min(l: List[float], m: float) -> bool:
    if not l:
        return False
    return m == min(l)

def is_list_max(l: List[float], m: float) -> bool:
    if not l:
        return False
    return m == max(l)

def problem_21_pre(input: List[float]) -> bool:
    return len(input) >= 2

def problem_21_spec(input: List[float], output: List[float]) -> bool:
    if not input:
        return False
    
    min_val = min(input)
    max_val = max(input)
    
    denom = max_val - min_val
    
    expected = []
    for x in input:
        if denom == 0.0:
            # In Coq, division by zero (x / 0) is defined as 0
            expected.append(0.0)
        else:
            expected.append((x - min_val) / denom)
            
    return output == expected
