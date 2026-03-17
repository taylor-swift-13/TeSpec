
def precondition(args):
    s, = args
    # Input must be a string
    if not isinstance(s, str):
        return False
    return True


def postcondition(args, output):
    s, = args
    # Output must be a non-negative integer
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # Output cannot exceed the number of even indices
    max_possible = (len(s) + 1) // 2
    if output > max_possible:
        return False
    # Verify the count is correct
    uppercase_vowels = set('AEIOU')
    expected_count = sum(1 for i in range(0, len(s), 2) if s[i] in uppercase_vowels)
    if output != expected_count:
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
