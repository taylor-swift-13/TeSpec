
def precondition(input):
    try:
        if len(input) != 1:
            return False
    except Exception:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, bool):
        return False
    s = input[0]
    n = len(s)
    expected = n >= 2
    if expected:
        i = 2
        while i * i <= n:
            if n % i == 0:
                expected = False
                break
            i += 1
    return output == expected

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
