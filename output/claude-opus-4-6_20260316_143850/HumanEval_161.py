
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    s = args[0]
    if not isinstance(s, str):
        return False
    return True


def postcondition(input, output):
    args = input
    s = args[0]
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    
    has_letter = any(c.isalpha() for c in s)
    
    if has_letter:
        for i in range(len(s)):
            if s[i].isalpha():
                if s[i].islower():
                    if output[i] != s[i].upper():
                        return False
                elif s[i].isupper():
                    if output[i] != s[i].lower():
                        return False
            else:
                if output[i] != s[i]:
                    return False
    else:
        if output != s[::-1]:
            return False
    
    return True

def _impl(s):
    """You are given a string s.
    if s[i] is a letter, reverse its case from lower to upper or vise versa, 
    otherwise keep it as it is.
    If the string contains no letters, reverse the string.
    The function should return the resulted string.
    Examples
    solve("1234") = "4321"
    solve("ab") = "AB"
    solve("#a@C") = "#A@c"
    """
    ans, has_letter = "", False
    for ch in s:
        if ch.isalpha():
            has_letter = True
            ans += ch.swapcase()
        else:
            ans += ch
    return ans if has_letter else s[::-1]

def solve(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
