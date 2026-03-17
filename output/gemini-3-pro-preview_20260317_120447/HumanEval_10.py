
def precondition(input_args: tuple) -> bool:
    return len(input_args) == 1 and isinstance(input_args[0], str)

def postcondition(input_args: tuple, output: str) -> bool:
    s = input_args[0]
    if not isinstance(output, str):
        return False
    
    # Check if output is a palindrome and starts with the input string
    is_palindrome = (output == output[::-1])
    starts_with_s = output.startswith(s)
    
    if not (is_palindrome and starts_with_s):
        return False
    
    # Find the length of the longest palindromic suffix of s
    # The shortest palindrome starting with s must have length:
    # len(s) + (len(s) - len(longest_palindromic_suffix))
    max_pal_suffix_len = 0
    for i in range(len(s) + 1):
        suffix = s[i:]
        if suffix == suffix[::-1]:
            max_pal_suffix_len = len(suffix)
            break
            
    expected_length = len(s) + (len(s) - max_pal_suffix_len)
    return len(output) == expected_length

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
