
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    if not isinstance(output, int):
        return False
    total = 0
    for x in range(n):
        if x % 11 == 0 or x % 13 == 0:
            total += str(x).count('7')
    return total == output

def _impl(n: int):
    """
    Return the number of times the digit 7 appears in integers less than n which are divisible by 11 or 13.
    0
    2
    3
    """
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
