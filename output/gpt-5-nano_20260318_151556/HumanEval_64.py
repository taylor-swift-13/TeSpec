
FIX = """
Add more test cases.
"""

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    vowels = set('aeiou')
    count = sum(1 for ch in s if ch.lower() in vowels)
    if len(s) > 0 and s[-1].lower() == 'y':
        count += 1
    return output == count

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
