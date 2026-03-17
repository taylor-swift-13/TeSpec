
def precondition(input):
    a, b = input
    return isinstance(a, str) and isinstance(b, str) and len(b) > 0

def postcondition(input, output):
    a, b = input
    if not isinstance(output, bool):
        return False
    
    n = len(b)
    rotations = [b[i:] + b[:i] for i in range(n)]
    expected = any(rot in a for rot in rotations)
    
    return output == expected

def _impl(a , b):
    """You are given 2 words. You need to return True if the second word or any of its rotations is a substring in the first word
    cycpattern_check("abcd","abd") => False
    cycpattern_check("hello","ell") => True
    cycpattern_check("whassup","psus") => False
    cycpattern_check("abab","baa") => True
    cycpattern_check("efef","eeff") => False
    cycpattern_check("himenss","simen") => True"""
    if a == b:
        return True
    if b == "":
        return True
    for i in range(0, len(b)):
        if b[i:] + b[:i] in a:
            return True
    return False

def cycpattern_check(a , b):
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
