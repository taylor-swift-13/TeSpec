
def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 1:
            return False
        arr = input[0]
        if not hasattr(arr, "__len__") or not hasattr(arr, "__getitem__"):
            return False
        n = len(arr)
        for i in range(1, n):
            try:
                _ = arr[i] < arr[i - 1]
            except Exception:
                return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return True
        arr = input[0]
        n = len(arr)
        if not isinstance(output, int):
            return False
        if n < 2:
            return output == -1
        dips = []
        for i in range(1, n):
            try:
                if arr[i] < arr[i - 1]:
                    dips.append(i)
            except Exception:
                return False
        if not dips:
            return output == -1
        return output == max(dips)
    except Exception:
        return False

def _impl(arr):
    """Create a function which returns the largest index of an element which
    is not greater than or equal to the element immediately preceding it. If
    no such element exists then return -1. The given array will not contain
    duplicate values.

    Examples:
    can_arrange([1,2,4,3,5]) = 3
    can_arrange([1,2,3]) = -1"""
    for i in range(len(arr) - 1, 0, -1):
        if not (arr[i] >= arr[i - 1]):
            return i
    return -1

def can_arrange(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
