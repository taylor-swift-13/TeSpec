
def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def precondition(input):
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, str):
        return False
    string = input[0]
    # Output must start with the input string
    if not output.startswith(string):
        return False
    # Output must be a palindrome
    if output != output[::-1]:
        return False
    # Output length must be at least the length of the input
    if len(output) < len(string):
        return False
    # Output should be the shortest such palindrome
    # No shorter string can start with `string` and be a palindrome
    for length in range(len(string), len(output)):
        candidate = string + string[:length - len(string)][::-1]
        # Actually, let's check all possible lengths
        # A palindrome starting with `string` of length L means:
        # output[:L] must equal output[:L][::-1] and output[:len(string)] == string
        pass
    # More direct check: for any shorter length, no palindrome starting with string exists
    for l in range(len(string), len(output)):
        # Build candidate of length l starting with string
        # For it to be a palindrome, characters at position i must equal character at position l-1-i
        # Positions 0..len(string)-1 are fixed by string
        # Positions len(string)..l-1 are free but determined by palindrome constraint
        candidate = list(string) + [''] * (l - len(string))
        valid = True
        for i in range(l):
            mirror = l - 1 - i
            if i < len(string) and mirror < len(string):
                if string[i] != string[mirror]:
                    valid = False
                    break
            elif i < len(string) and mirror >= len(string):
                candidate[mirror] = string[i]
            elif i >= len(string) and mirror < len(string):
                if candidate[i] == '':
                    candidate[i] = string[mirror]
                elif candidate[i] != string[mirror]:
                    valid = False
                    break
        if valid and all(c != '' for c in candidate):
            # A shorter palindrome exists, so output is not shortest
            return False
    return True

def _impl(string: str) -> str:
    """
    Find the shortest palindrome that begins with a supplied string.
    Algorithm idea is simple:
    - Find the longest postfix of supplied string that is a palindrome.
    - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
    ''
    'catac'
    'catac'
    """
    if is_palindrome(string):
        return string
    for i in range(len(string)):
        if is_palindrome(string[i:]):
            return string + string[i-1::-1]

def make_palindrome(string: str) -> str:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
