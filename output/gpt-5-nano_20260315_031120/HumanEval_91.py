
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    S = input[0]
    if not isinstance(S, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    S = input[0]
    if not isinstance(S, str):
        return False
    if not isinstance(output, int):
        return False
    if output < 0:
        return False

    import re
    segments = re.split(r'[.?!]', S)
    count = 0
    for seg in segments:
        seg = seg.strip()
        if not seg:
            continue
        words = seg.split()
        if words and words[0] == "I":
            count += 1

    return count == output

def _impl(S):
    """You'll be given a string of words, and your task is to count the number
    of boredoms. A boredom is a sentence that starts with the word "I".
    Sentences are delimited by '.', '?' or '!'.

    For example:
    0
    1"""
    sentences = map(lambda x: x.strip(), ((S.replace("?", ".")).replace("!", ".")).split("."))
    return len([s for s in sentences if s.startswith("I ")])

def is_bored(S):
    _input = (S,)
    assert precondition(_input)
    _output = _impl(S)
    assert postcondition(_input, _output)
    return _output
