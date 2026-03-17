
def precondition(input):
    return isinstance(input[0], str)

def postcondition(input, output):
    s = input[0]
    n = len(s)
    if n < 2:
        is_prime = False
    else:
        is_prime = True
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                is_prime = False
                break
    return isinstance(output, bool) and output == is_prime

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
