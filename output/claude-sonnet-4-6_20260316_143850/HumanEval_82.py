
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, bool):
        return False
    string = input[0]
    n = len(string)
    if n < 2:
        expected = False
    else:
        expected = True
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                expected = False
                break
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
