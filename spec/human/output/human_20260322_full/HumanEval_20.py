from typing import List, Tuple

def problem_20_pre(input):
    return len(input) >= 2

def problem_20_spec(input, output1, output2):
    if len(input) < 2:
        return False
        
    if output1 not in input or output2 not in input:
        return False
        
    if output1 > output2:
        return False
        
    diff = abs(output1 - output2)
    
    for i in range(len(input)):
        for j in range(len(input)):
            if i != j:
                if diff > abs(input[i] - input[j]):
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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_20_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_20_spec(*input, output))

def find_closest_elements(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
