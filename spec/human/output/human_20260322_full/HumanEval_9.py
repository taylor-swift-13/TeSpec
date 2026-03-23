from typing import List, Tuple

def problem_9_pre():
    return True

def problem_9_spec(input, output):
    if len(input) != len(output):
        return False
    
    for i in range(len(output)):
        # Check that all elements up to i in input are <= output[i]
        for j in range(i + 1):
            if input[j] > output[i]:
                return False
                
        # Check that there exists some element up to i in input equal to output[i]
        found = False
        for j in range(i + 1):
            if input[j] == output[i]:
                found = True
                break
                
        if not found:
            return False
            
    return True

def _impl(numbers: List[int]) -> List[int]:
    return [max(numbers[:(i+1)]) for i in range(len(numbers))]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_9_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_9_spec(*input, output))

def rolling_max(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
