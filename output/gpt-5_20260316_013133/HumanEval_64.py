
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if type(output) is not int:
        return False
    s = input[0]
    vowels = set('aeiou')

    # Lowercase-only interpretation
    lower_only = sum(1 for ch in s if ch in vowels)
    if len(s) > 0 and s[-1] == 'y':
        lower_only += 1

    # Case-insensitive interpretation
    sl = s.lower()
    case_insensitive = sum(1 for ch in sl if ch in vowels)
    if len(sl) > 0 and sl[-1] == 'y':
        case_insensitive += 1

    return 0 <= output <= len(s) and (output == lower_only or output == case_insensitive)

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
