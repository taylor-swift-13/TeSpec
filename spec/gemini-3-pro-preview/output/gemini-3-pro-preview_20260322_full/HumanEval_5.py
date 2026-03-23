from typing import List

def intersperse(numbers, delimeter):
    if not numbers:
        return []
    
    # The Coq definition handles the single element case specifically:
    # | h :: [] => [h]
    # And the recursive step:
    # | h :: t => h :: delimeter :: intersperse t delimeter
    #
    # We implement this iteratively for Python efficiency while preserving behavior.
    
    result = [numbers[0]]
    for x in numbers[1:]:
        result.append(delimeter)
        result.append(x)
        
    return result

def intersperse_spec(numbers, delimeter, res):
    return res == intersperse(numbers, delimeter)

def _impl(numbers: List[int], delimeter: int) -> List[int]:
    res = []
    for i in range(len(numbers)):
        res.append(numbers[i])
        if i != len(numbers) - 1:
            res.append(delimeter)
    return res

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(intersperse_spec(*input, output))

def intersperse(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
