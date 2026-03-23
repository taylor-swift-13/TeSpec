def sort_array_spec(array, res):
    if not array:
        return res == []
    
    first = array[0]
    last_val = array[-1]
    sum_val = first + last_val
    
    # Check if res is a permutation of array
    if sorted(array) != sorted(res):
        return False
        
    # Check sortedness based on the parity of sum_val
    if sum_val % 2 != 0:
        # Odd: sorted ascending (Z.le)
        return res == sorted(array)
    else:
        # Even: sorted descending (Z.ge)
        return res == sorted(array, reverse=True)

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
