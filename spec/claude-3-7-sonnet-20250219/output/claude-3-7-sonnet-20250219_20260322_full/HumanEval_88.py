def sorted_asc(l):
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if l[i] > l[j]:
                return False
    return True

def sorted_desc(l):
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if l[i] < l[j]:
                return False
    return True

def sort_array_spec(array, result):
    if len(array) == 0 and len(result) == 0:
        return True
    if len(array) > 0:
        sum_val = array[0] + array[-1]
        if sum_val % 2 != 0:
            cond1 = sorted_asc(result)
        else:
            cond1 = sorted_desc(result)
        cond2 = set(result) == set(array)
        return cond1 and cond2
    return False

def _impl(array):
    if array == []: return []
    return sorted(array, reverse=(array[0]+array[-1]) % 2 == 0)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sort_array_spec(*input, output))

def sort_array(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
