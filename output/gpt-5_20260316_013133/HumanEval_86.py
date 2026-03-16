
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str) or not isinstance(output, str):
        return False
    if len(s) != len(output):
        return False
    # Spaces must remain spaces at the same positions
    for i, ch in enumerate(s):
        if (ch == ' ') != (output[i] == ' '):
            return False
    # Each contiguous non-space block must be sorted ascending and preserve characters
    n = len(s)
    i = 0
    while i < n:
        if s[i] == ' ':
            i += 1
            continue
        j = i
        while j < n and s[j] != ' ':
            j += 1
        ss = s[i:j]
        oo = output[i:j]
        if oo != ''.join(sorted(ss)):
            return False
        i = j
    return True

def _impl(s):
    """Write a function that takes a string and returns an ordered version of it.
    Ordered version of string, is a string where all words (separated by space)
    are replaced by a new word where all the characters arranged in
    ascending order based on ascii value.
    Note: You should keep the order of words and blank spaces in the sentence.

    For example:
    anti_shuffle('Hi') returns 'Hi'
    anti_shuffle('hello') returns 'ehllo'
    anti_shuffle('Hello World!!!') returns 'Hello !!!Wdlor'"""
    words = s.split(" ")
    return " ".join(map(lambda x: "".join(sorted(x, key=lambda ch: ord(ch))), words))

def anti_shuffle(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
