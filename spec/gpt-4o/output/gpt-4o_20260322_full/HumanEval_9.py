from typing import List, Tuple

def rolling_max_spec(numbers, result):
    if len(numbers) != len(result):
        return False
    
    current_max = 0
    for i in range(len(numbers)):
        current_max = max(current_max, numbers[i])
        if result[i] != current_max:
            return False
            
    return True

def _impl(numbers: List[int]) -> List[int]:
    return [max(numbers[:(i+1)]) for i in range(len(numbers))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(rolling_max_spec(*input, output))

def rolling_max(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
