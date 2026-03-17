
def precondition(input):
    if not isinstance(input, tuple) and not isinstance(input, list):
        return False
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True


def postcondition(input, output):
    string = input[0]
    if not isinstance(output, str):
        return False
    # Output must be a palindrome
    if output != output[::-1]:
        return False
    # Output must start with the supplied string
    if not output.startswith(string):
        return False
    # Output length must be at least the length of the input string
    if len(output) < len(string):
        return False
    # Output should be the shortest such palindrome
    # No shorter string can be a palindrome starting with the input string
    for length in range(len(string), len(output)):
        candidate = string + string[:length - len(string)][::-1]
        # Actually, let's check all possible lengths
        # Build candidate of given length that starts with string
        # The candidate must start with string, so first len(string) chars are fixed
        # For it to be a palindrome, the remaining chars are determined
        prefix = string
        needed_len = length
        if needed_len < len(string):
            continue
        # Build the palindrome candidate of this length starting with string
        candidate = list(string) + [None] * (needed_len - len(string))
        valid = True
        for i in range(needed_len):
            j = needed_len - 1 - i
            if candidate[i] is not None and candidate[j] is not None:
                if candidate[i] != candidate[j]:
                    valid = False
                    break
            elif candidate[i] is not None:
                candidate[j] = candidate[i]
            elif candidate[j] is not None:
                candidate[i] = candidate[j]
        if valid and all(c is not None for c in candidate):
            built = ''.join(candidate)
            if built == built[::-1] and built.startswith(string):
                if length < len(output):
                    return False
    return True

def _impl(string: str) -> str:
    """Find the shortest palindrome that begins with a supplied string.
    Algorithm idea is simple:
    - Find the longest postfix of supplied string that is a palindrome.
    - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
    ''
    'catac'
    'catac'"""
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
