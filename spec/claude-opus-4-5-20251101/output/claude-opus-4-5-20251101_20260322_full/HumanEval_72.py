def sum_list(l):
    """
    Calculates the sum of elements in a list of integers.
    """
    s = 0
    for x in l:
        s += x
    return s

def is_palindrome(l):
    """
    Checks if a list is a palindrome (equal to its reverse).
    """
    return l == l[::-1]

def will_it_fly_spec(q, w, result):
    """
    Specification for will_it_fly.
    Returns True if the boolean 'result' correctly reflects whether 
    the list 'q' is a palindrome and its sum is less than or equal to 'w'.
    """
    condition = is_palindrome(q) and sum_list(q) <= w
    return result == condition

def _impl(q, w):
    return q == q[::-1] and sum(q) <= w

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(will_it_fly_spec(*input, output))

def will_it_fly(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
