
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    a = input[0]
    if not isinstance(a, int):
        return False
    if not (0 < a < 100):
        return False
    return True

def _omega(n: int) -> int:
    count = 0
    d = 2
    while d * d <= n:
        while n % d == 0:
            count += 1
            n //= d
        d += 1
    if n > 1:
        count += 1
    return count

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    a = input[0]
    if not isinstance(a, int) or not (0 < a < 100):
        return False
    expected = (_omega(a) == 3)
    return output == expected

def _impl(a):
    """
    Write a function that returns true if the given number is the multiplication of 3 prime numbers
    and false otherwise.
    Knowing that (a) is less then 100. 
    Example:
    is_multiply_prime(30) == True
    30 = 2 * 3 * 5
    """
    if a <= 1: return False
    isprime = [True] * (a + 1)
    for i in range(2, a + 1):
        if isprime[i]:
            for j in range(i + i, a + 1, i):
                isprime[j] = False
    cnt, tmp = 0, a
    for i in range(2, a + 1):
        while isprime[i] and tmp % i == 0:
            tmp //= i
            cnt += 1
    return cnt == 3

def is_multiply_prime(a):
    _input = (a,)
    assert precondition(_input)
    _output = _impl(a)
    assert postcondition(_input, _output)
    return _output
