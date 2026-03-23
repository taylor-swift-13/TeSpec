def problem_37_pre(input):
    return True

def problem_37_spec(input, output):
    if len(input) != len(output):
        return False
    
    # 1. input is a permutation of output
    if sorted(input) != sorted(output):
        return False
    
    # 2. For odd indices, output[i] must equal input[i]
    for i in range(len(input)):
        if i % 2 != 0:
            if output[i] != input[i]:
                return False
                
    # 3. Elements at even indices in output must be sorted in non-decreasing order
    even_elements = [output[i] for i in range(len(output)) if i % 2 == 0]
    if even_elements != sorted(even_elements):
        return False
        
    return True

def _impl(l: list):
    even = [l[i] for i in range(len(l)) if i % 2 == 0]
    even.sort()
    return [even[i // 2] if i % 2 == 0 else l[i] for i in range(len(l))]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_37_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_37_spec(*input, output))

def sort_even(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
