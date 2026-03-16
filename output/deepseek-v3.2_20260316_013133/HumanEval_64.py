
def precondition(args):
    s = args[0]
    return isinstance(s, str)

def postcondition(args, result):
    s = args[0]
    if not isinstance(result, int):
        return False
    if result < 0:
        return False
    vowels = set('aeiou')
    count = 0
    for i, ch in enumerate(s.lower()):
        if ch in vowels:
            count += 1
        elif ch == 'y' and i == len(s) - 1:
            count += 1
    return result == count

def _impl(s):
    """Write a function vowels_count which takes a string representing
    a word as input and returns the number of vowels in the string.
    Vowels in this case are 'a', 'e', 'i', 'o', 'u'. Here, 'y' is also a
    vowel, but only when it is at the end of the given word.

    Example:
    2
    3"""
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
