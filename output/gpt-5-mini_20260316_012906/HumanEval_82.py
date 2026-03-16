
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    n = len(s)
    def is_prime(k):
        if k < 2:
            return False
        if k == 2:
            return True
        if k % 2 == 0:
            return False
        i = 3
        while i * i <= k:
            if k % i == 0:
                return False
            i += 2
        return True
    expected = is_prime(n)
    return isinstance(output, bool) and output == expected

def _impl(string):
    """Write a function that takes a string and returns True if the string
    length is a prime number or False otherwise
    Examples
    prime_length('Hello') == True
    prime_length('abcdcba') == True
    prime_length('kittens') == True
    prime_length('orange') == False"""
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))

    return is_prime(len(string))

def prime_length(string):
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
