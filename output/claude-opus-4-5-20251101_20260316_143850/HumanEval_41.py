
def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    if not isinstance(output, int):
        return False
    if isinstance(output, bool):
        return False
    if output < 0:
        return False
    # Each of the n left-to-right cars will collide with each of the n right-to-left cars
    # Total collisions = n * n
    if output != n * n:
        return False
    return True

def _impl(n: int):
    """Imagine a road that's a perfectly straight infinitely long line.
    n cars are driving left to right;  simultaneously, a different set of n cars
    are driving right to left.   The two sets of cars start out being very far from
    each other.  All cars move in the same speed.  Two cars are said to collide
    when a car that's moving left to right hits a car that's moving right to left.
    However, the cars are infinitely sturdy and strong; as a result, they continue moving
    in their trajectory as if they did not collide.

    This function outputs the number of such collisions."""
    return n ** 2

def car_race_collision(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
