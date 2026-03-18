
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if type(n) is int and n >= 0:
        return True
    return False

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if type(n) is int and n >= 0:
        return isinstance(output, int) and output == n * n
    return False

def _impl(n: int):
    """
    Imagine a road that's a perfectly straight infinitely long line.
    n cars are driving left to right;  simultaneously, a different set of n cars
    are driving right to left.   The two sets of cars start out being very far from
    each other.  All cars move in the same speed.  Two cars are said to collide
    when a car that's moving left to right hits a car that's moving right to left.
    However, the cars are infinitely sturdy and strong; as a result, they continue moving
    in their trajectory as if they did not collide.

    This function outputs the number of such collisions.
    """
    return n ** 2

def car_race_collision(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
