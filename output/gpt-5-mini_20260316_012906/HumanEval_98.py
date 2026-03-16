
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    s = input[0]
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    expected = 0
    for i, ch in enumerate(s):
        if i % 2 == 0 and ch in "AEIOU":
            expected += 1
    return output == expected

def _impl(s):
    """Given a string s, count the number of uppercase vowels in even indices.

    For example:
    count_upper('aBCdEf') returns 1
    count_upper('abcdefg') returns 0
    count_upper('dBBE') returns 0"""
    cnt = 0
    for i in range(0, len(s), 2):
        if s[i] in "AEIOU":
            cnt += 1
    return cnt

def count_upper(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
