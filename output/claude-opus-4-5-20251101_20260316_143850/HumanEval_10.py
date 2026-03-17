
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
    # Output should be the shortest such palindrome:
    # No shorter string can start with `string` and be a palindrome
    for length in range(len(string), len(output)):
        candidate = string + string[:length - len(string)]
        # We need candidate of exactly `length` chars starting with `string`
        # Actually let's check differently: any palindrome starting with `string`
        # of length < len(output) should not exist
        pass
    # More direct check: for any length from len(string) to len(output)-1,
    # there should be no palindrome of that length starting with string
    for l in range(len(string), len(output)):
        # A palindrome of length l starting with string:
        # first len(string) chars are fixed as `string`
        # remaining chars are determined by palindrome constraint
        # For it to be a palindrome: s[i] == s[l-1-i] for all i
        # Characters 0..len(string)-1 are known
        # Characters len(string)..l-1 must satisfy: s[i] = s[l-1-i]
        # For i in range(len(string), l): s[i] = s[l-1-i]
        # where l-1-i < len(string) since i >= len(string) means l-1-i <= l-1-len(string) < l - len(string) <= len(string)-1 when l < 2*len(string)
        # Let's just construct the candidate and check consistency
        candidate = list(string) + [None] * (l - len(string))
        valid = True
        for i in range(l):
            j = l - 1 - i
            if i < j:
                ci = candidate[i] if i < len(candidate) else None
                cj = candidate[j] if j < len(candidate) else None
                if ci is not None and cj is not None:
                    if ci != cj:
                        valid = False
                        break
                elif ci is not None and cj is None:
                    candidate[j] = ci
                elif cj is not None and ci is None:
                    candidate[i] = cj
        if valid and all(c is not None for c in candidate):
            # A shorter palindrome exists, so output is not shortest
            return False
    return True

def _impl(string: str) -> str:
    """Find the shortest palindrome that begins with a supplied string.
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
