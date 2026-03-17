
def precondition(input):
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    has_letter = any(c.isalpha() for c in s)
    if not has_letter:
        return output == s[::-1]
    else:
        for c_in, c_out in zip(s, output):
            if c_in.isalpha():
                if c_out != c_in.swapcase():
                    return False
            else:
                if c_out != c_in:
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
