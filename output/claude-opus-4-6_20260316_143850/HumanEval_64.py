
def precondition(input):
    (s,) = input
    if not isinstance(s, str):
        return False
    if len(s) == 0:
        return False
    # The string should represent a word (alphabetic characters)
    if not all(c.isalpha() for c in s):
        return False
    return True


def postcondition(input, output):
    (s,) = input
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # Count vowels manually to verify
    vowels = "aeiouAEIOU"
    count = sum(1 for c in s if c in vowels)
    # Check if 'y' or 'Y' is at the end
    if s[-1] in ('y', 'Y'):
        count += 1
    if output != count:
        return False
    return True

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
