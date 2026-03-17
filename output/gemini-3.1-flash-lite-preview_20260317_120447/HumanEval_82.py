
def precondition(input):
    return isinstance(input[0], str)

def postcondition(input, output):
    n = len(input[0])
    if n < 2:
        expected = False
    else:
        expected = all(n % i != 0 for i in range(2, int(n**0.5) + 1))
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
