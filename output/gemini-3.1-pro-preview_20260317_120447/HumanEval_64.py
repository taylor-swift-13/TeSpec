
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output) -> bool:
    if not isinstance(output, int):
        return False
    s = input[0]
    return 0 <= output <= len(s)

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
