def problem_34_pre(input):
    return True

def problem_34_spec(input, output):
    # 1. Check if output is sorted
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
            
    # 2. Check if output has unique elements
    if len(set(output)) != len(output):
        return False
        
    # 3. Check if input and output have the same elements
    if set(input) != set(output):
        return False
        
    return True

def _impl(l: list):
    return sorted(set(l))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_34_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_34_spec(*input, output))

def unique(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
