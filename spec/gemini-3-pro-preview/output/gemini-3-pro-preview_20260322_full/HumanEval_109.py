def is_cyclic_shift(l1, l2):
    if len(l1) != len(l2):
        return False
    for i in range(len(l1) + 1):
        if l2 == l1[i:] + l1[:i]:
            return True
    return False

def move_one_ball_spec(arr, result):
    exists_sorted_shift = False
    for i in range(len(arr) + 1):
        l_prime = arr[i:] + arr[:i]
        is_sorted = all(l_prime[j] <= l_prime[j+1] for j in range(len(l_prime) - 1))
        if is_sorted:
            exists_sorted_shift = True
            break
    return bool(result) == exists_sorted_shift

def _impl(arr):
    sorted_arr = sorted(arr)
    if arr == sorted_arr: return True
    for i in range(1, len(arr)):
        if arr[i:] + arr[:i] == sorted_arr:
            return True
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(move_one_ball_spec(*input, output))

def move_one_ball(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
