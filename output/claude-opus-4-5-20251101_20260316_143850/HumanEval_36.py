
def precondition(input):
    n = input[0]
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # Count sevens in numbers less than n divisible by 11 or 13
    expected = 0
    for i in range(n):
        if i % 11 == 0 or i % 13 == 0:
            expected += str(i).count('7')
    return output == expected

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
