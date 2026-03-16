
def precondition(input) -> bool:
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output) -> bool:
    if not (isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)):
        return False
    if not isinstance(output, str):
        return False
    s = input[0]
    has_letter = any(c.isalpha() for c in s)
    if has_letter:
        expected = "".join(c.swapcase() if c.isalpha() else c for c in s)
    else:
        expected = s[::-1]
    return output == expected

def _impl(s):
    """You are given a string s.
    if s[i] is a letter, reverse its case from lower to upper or vise versa, 
    otherwise keep it as it is.
    If the string contains no letters, reverse the string.
    The function should return the resulted string.
    Examples
    solve("1234") = "4321"
    solve("ab") = "AB"
    solve("#a@C") = "#A@c""""
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
