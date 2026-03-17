
def precondition(input) -> bool:
    if len(input) != 2:
        return False
    q, w = input
    if not isinstance(q, list):
        return False
    if not isinstance(w, (int, float)):
        return False
    if not all(isinstance(x, (int, float)) for x in q):
        return False
    return True

def postcondition(input, output) -> bool:
    q, w = input
    if not isinstance(output, bool):
        return False
    expected = (q == q[::-1]) and (sum(q) <= w)
    return output == expected

def _impl(q,w):
    """Write a function that returns True if the object q will fly, and False otherwise.
    The object q will fly if it's balanced (it is a palindromic list) and the sum of its elements is less than or equal the maximum possible weight w.

    Example:
    will_it_fly([1, 2], 5) ➞ False 
    # 1+2 is less than the maximum possible weight, but it's unbalanced.

    will_it_fly([3, 2, 3], 1) ➞ False
    # it's balanced, but 3+2+3 is more than the maximum possible weight.

    will_it_fly([3, 2, 3], 9) ➞ True
    # 3+2+3 is less than the maximum possible weight, and it's balanced.

    will_it_fly([3], 5) ➞ True
    # 3 is less than the maximum possible weight, and it's balanced."""
    return q == q[::-1] and sum(q) <= w

def will_it_fly(q,w):
    _input = (q, w)
    assert precondition(_input)
    _output = _impl(q, w)
    assert postcondition(_input, _output)
    return _output
