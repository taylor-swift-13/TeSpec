
def precondition(input):
    string, = input
    return isinstance(string, str)

def postcondition(input, output):
    string, = input
    if not isinstance(output, bool):
        return False
    if not isinstance(string, str):
        return False
    length = len(string)
    if length < 2:
        return output == False
    for i in range(2, int(length**0.5) + 1):
        if length % i == 0:
            return output == False
    return output == True

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
