def problem_88_pre(input):
    return True

def problem_88_spec(input, output):
    if sorted(input) != sorted(output):
        return False
        
    if len(input) == 0:
        return output == []
    elif len(input) == 1:
        return output == input
    else:
        h = input[0]
        last_elem = input[-1]
        
        if (h + last_elem) % 2 == 1:
            return output == sorted(input)
        else:
            return output == sorted(input, reverse=True)

def _impl(array):
    if array == []: return []
    return sorted(array, reverse=(array[0]+array[-1]) % 2 == 0)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_88_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_88_spec(*input, output))

def sort_array(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
