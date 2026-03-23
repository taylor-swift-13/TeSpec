def problem_33_pre(input):
    return True

def problem_33_spec(input, output):
    # 1. input and output must have the same length
    if len(input) != len(output):
        return False
        
    # 1. input must be a permutation of output
    if sorted(input) != sorted(output):
        return False

    # 2. If index i is not divisible by 3, output[i] must equal input[i]
    for i in range(len(input)):
        if i % 3 != 0:
            if output[i] != input[i]:
                return False

    # 3. Elements in output at indices divisible by 3 must be sorted (non-decreasing)
    div_3_vals = [output[i] for i in range(len(output)) if i % 3 == 0]
    if div_3_vals != sorted(div_3_vals):
        return False

    return True

def _impl(l: list):
    third = [l[i] for i in range(len(l)) if i % 3 == 0]
    third.sort()
    return [third[i // 3] if i % 3 == 0 else l[i] for i in range(len(l))]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_33_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_33_spec(*input, output))

def sort_third(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
