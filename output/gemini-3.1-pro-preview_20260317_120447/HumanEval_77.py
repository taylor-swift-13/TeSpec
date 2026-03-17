
def precondition(inputs):
    if len(inputs) != 1:
        return False
    a = inputs[0]
    return isinstance(a, int)

def postcondition(inputs, output):
    if len(inputs) != 1:
        return False
    a = inputs[0]
    if not isinstance(output, bool):
        return False
        
    abs_a = abs(a)
    low = 0
    high = abs_a
    is_cube = False
    
    while low <= high:
        mid = (low + high) // 2
        mid3 = mid ** 3
        if mid3 == abs_a:
            is_cube = True
            break
        elif mid3 < abs_a:
            low = mid + 1
        else:
            high = mid - 1
            
    return output == is_cube

def _impl(a):
    """Write a function that takes an integer a and returns True 
    if this ingeger is a cube of some integer number.
    Note: you may assume the input is always valid.
    Examples:
    iscube(1) ==> True
    iscube(2) ==> False
    iscube(-1) ==> True
    iscube(64) ==> True
    iscube(0) ==> True
    iscube(180) ==> False"""
    a = abs(a)
    return int(round(a ** (1. / 3))) ** 3 == a

def iscube(a):
    _input = (a,)
    assert precondition(_input)
    _output = _impl(a)
    assert postcondition(_input, _output)
    return _output
