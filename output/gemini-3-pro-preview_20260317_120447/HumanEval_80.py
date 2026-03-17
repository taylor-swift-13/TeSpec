
def precondition(input_args):
    return isinstance(input_args[0], str)

def postcondition(input_args, output):
    s = input_args[0]
    if not isinstance(output, bool):
        return False
    
    if len(s) < 3:
        expected = False
    else:
        expected = True
        for i in range(len(s) - 2):
            triple = s[i:i+3]
            if len(set(triple)) < 3:
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
