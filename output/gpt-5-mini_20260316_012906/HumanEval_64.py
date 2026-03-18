
FIX = """
Add more test cases.
"""

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    if output < 0 or output > len(s):
        return False
    vowels = set('aeiou')
    exp = 0
    L = len(s)
    for i, ch in enumerate(s):
        cl = ch.lower()
        if cl in vowels:
            exp += 1
        elif cl == 'y' and i == L - 1 and L > 0:
            exp += 1
    return output == exp

def _impl(s):
    """
    Write a function vowels_count which takes a string representing
    a word as input and returns the number of vowels in the string.
    Vowels in this case are 'a', 'e', 'i', 'o', 'u'. Here, 'y' is also a
    vowel, but only when it is at the end of the given word.

    Example:
    2
    3
    """
    if s == "": return 0
    cnt = len(list(filter(lambda ch: ch in "aeiouAEIOU", s)))
    if s[-1] in "yY": cnt += 1
    return cnt

def vowels_count(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
