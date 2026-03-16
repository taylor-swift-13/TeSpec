
def precondition(args):
    s, = args
    return isinstance(s, str)

def postcondition(args, result):
    s, = args
    if not isinstance(result, int):
        return False
    if result < 0:
        return False
    # Conservative check: result shouldn't exceed number of even indices
    even_indices = [i for i in range(0, len(s), 2)]
    if result > len(even_indices):
        return False
    # Conservative check: result shouldn't exceed total uppercase vowels in string
    uppercase_vowels = set('AEIOU')
    total_upper_vowels = sum(1 for ch in s if ch in uppercase_vowels)
    if result > total_upper_vowels:
        return False
    return True

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
