
def precondition(input):
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    a, b = input
    # Verify: output is True if any rotation of b is a substring of a
    if len(b) == 0:
        return output == True
    rotations = set()
    doubled = b + b
    for i in range(len(b)):
        rotations.add(doubled[i:i+len(b)])
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
