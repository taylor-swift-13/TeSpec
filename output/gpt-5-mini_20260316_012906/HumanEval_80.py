
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    # If precondition not met, do not enforce postcondition here.
    if not precondition(input):
        return True
    s = input[0]
    # output must be a boolean
    if not isinstance(output, bool):
        return False
    # expected behavior: True iff len(s) >= 3 and every 3 consecutive characters are pairwise distinct
    if len(s) < 3:
        expected = False
    else:
        expected = True
        for i in range(len(s) - 2):
            a, b, c = s[i], s[i+1], s[i+2]
            if a == b or a == c or b == c:
                expected = False
                break
    return output == expected

def _impl(s):
    """You are given a string s.
    Your task is to check if the string is happy or not.
    A string is happy if its length is at least 3 and every 3 consecutive letters are distinct
    For example:
    is_happy(a) => False
    is_happy(aa) => False
    is_happy(abcd) => True
    is_happy(aabb) => False
    is_happy(adb) => True
    is_happy(xyy) => False"""
    if len(s) < 3: return False
    for i in range(len(s) - 2):
        if s[i] == s[i + 1] or s[i] == s[i + 2] or s[i + 1] == s[i + 2]:
            return False
    return True

def is_happy(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
