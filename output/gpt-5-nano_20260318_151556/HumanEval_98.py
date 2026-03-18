
def precondition(input):
    # input should be a tuple with a single string argument: (s,)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    # Verify output matches the number of uppercase vowels ('AEIOU') at even indices in s
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, int):
        return False
    expected = sum(1 for i, ch in enumerate(s) if i % 2 == 0 and ch in 'AEIOU')
    return output == expected

def _impl(s):
    """
    Given a string s, count the number of uppercase vowels in even indices.

    For example:
    count_upper('aBCdEf') returns 1
    count_upper('abcdefg') returns 0
    count_upper('dBBE') returns 0
    """
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
