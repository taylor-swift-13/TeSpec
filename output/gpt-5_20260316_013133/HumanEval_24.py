
def precondition(input):
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 1:
            return False
        n = input[0]
        if not isinstance(n, int):
            return False
        if n >= 2:
            return True
        return False
    except Exception:
        return False


def postcondition(input, output):
    try:
        if not precondition(input):
            return True
        n = input[0]
        if type(output) is not int:
            return False
        if output < 1 or output >= n:
            return False
        if n % output != 0:
            return False
        if output > n // 2:
            return False
        max_candidate = n // 2
        for d in range(output + 1, max_candidate + 1):
            if n % d == 0:
                return False
        return True
    except Exception:
        return False

def _impl(n: int) -> int:
    """For a given number n, find the largest number that divides n evenly, smaller than n
    5"""
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def largest_divisor(n: int) -> int:
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
