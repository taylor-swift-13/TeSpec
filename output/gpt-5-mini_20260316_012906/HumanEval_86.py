
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    # spaces must be preserved at the same positions
    for a, b in zip(s, output):
        if (a == ' ') != (b == ' '):
            return False
    # compare each space-separated segment: output segment must be sorted characters of input segment
    s_segs = s.split(' ')
    o_segs = output.split(' ')
    if len(s_segs) != len(o_segs):
        return False
    for seg_s, seg_o in zip(s_segs, o_segs):
        if ''.join(sorted(seg_s)) != seg_o:
            return False
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
