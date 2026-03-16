
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    return isinstance(n, int) and n >= 0


def postcondition(input, output):
    if not isinstance(output, int) or output < 0:
        return False
    n = input[0]
    count = 0
    for k in range(n):
        if (k % 11 == 0) or (k % 13 == 0):
            count += str(k).count('7')
    return output == count

def _impl(n: int):
    """Return the number of times the digit 7 appears in integers less than n which are divisible by 11 or 13.
    0
    2
    3"""
    cnt = 0
    for i in range(n):
        if i % 11 == 0 or i % 13 == 0:
            cnt += len(list(filter(lambda c: c == "7", str(i))))
    return cnt

def fizz_buzz(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
