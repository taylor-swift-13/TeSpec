
FIX = """
Add more test cases.
"""

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, int):
        return False
    if output < 0 or output > len(s):
        return False

    vowels = set("aeiou")
    # Variants to avoid over-restricting case handling
    # Vowels case-sensitive / y case-sensitive
    c1 = sum(ch in vowels for ch in s) + (1 if s.endswith("y") else 0)
    # Vowels case-sensitive / y case-insensitive at end
    c2 = sum(ch in vowels for ch in s) + (1 if len(s) > 0 and s[-1].lower() == "y" else 0)
    # Vowels case-insensitive / y case-sensitive at end
    sl = s.lower()
    c3 = sum(ch in vowels for ch in sl) + (1 if s.endswith("y") else 0)
    # Vowels case-insensitive / y case-insensitive at end
    c4 = sum(ch in vowels for ch in sl) + (1 if len(s) > 0 and s[-1].lower() == "y" else 0)

    allowed = {c1, c2, c3, c4}
    return output in allowed

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
