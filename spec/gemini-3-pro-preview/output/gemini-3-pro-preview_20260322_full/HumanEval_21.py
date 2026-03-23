from typing import List

def rescale_to_unit_spec(numbers, result):
    if not numbers:
        return False
    
    mi = min(numbers)
    ma = max(numbers)
    
    if mi == ma:
        return False
        
    if len(numbers) != len(result):
        return False
        
    for x, y in zip(numbers, result):
        expected = (x - mi) * (1.0 / (ma - mi))
        # Using a small tolerance for floating-point comparison
        if abs(expected - y) > 1e-7:
            return False
            
    return True

def _impl(numbers: List[float]) -> List[float]:
    ma, mi = max(numbers), min(numbers)
    k = 1 / (ma - mi)
    return list(map(lambda x: (x - mi) * k, numbers))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(rescale_to_unit_spec(*input, output))

def rescale_to_unit(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
