from typing import List, Tuple

def find_closest_elements_spec(numbers, result):
    if len(numbers) < 2:
        return True
    
    a, b = result
    if a > b:
        return False
        
    n = len(numbers)
    
    # Check exists i j : nat, i <> j /\ numbers[i] == a /\ numbers[j] == b
    found = False
    for i in range(n):
        for j in range(n):
            if i != j and numbers[i] == a and numbers[j] == b:
                found = True
                break
        if found:
            break
            
    if not found:
        return False
        
    # Check forall i j : nat, i <> j -> b - a <= abs(numbers[i] - numbers[j])
    for i in range(n):
        for j in range(n):
            if i != j:
                if b - a > abs(numbers[i] - numbers[j]):
                    return False
                    
    return True

def _impl(numbers: List[float]) -> Tuple[float, float]:
    numbers.sort()
    min_diff = float("inf")
    min_pair = None
    for l, r in zip(numbers[:-1], numbers[1:]):
        diff = r - l
        if diff < min_diff:
            min_diff = diff
            min_pair = (l, r)
    return min_pair

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(find_closest_elements_spec(*input, output))

def find_closest_elements(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
