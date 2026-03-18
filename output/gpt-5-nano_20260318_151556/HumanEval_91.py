
import re

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    S = input[0]
    if not isinstance(S, str):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, int):
        return False
    S = input[0]
    parts = re.split(r'[.!?]', S)
    count = 0
    for part in parts:
        s = part.strip()
        if not s:
            continue
        words = s.split()
        if words and words[0] == 'I':
            count += 1
    return output == count

def _impl(S):
    """
    You'll be given a string of words, and your task is to count the number
    of boredoms. A boredom is a sentence that starts with the word "I".
    Sentences are delimited by '.', '?' or '!'.

    For example:
    0
    1
    """
    sentences = map(lambda x: x.strip(), ((S.replace("?", ".")).replace("!", ".")).split("."))
    return len([s for s in sentences if s.startswith("I ")])

def is_bored(S):
    _input = (S,)
    assert precondition(_input)
    _output = _impl(S)
    assert postcondition(_input, _output)
    return _output
