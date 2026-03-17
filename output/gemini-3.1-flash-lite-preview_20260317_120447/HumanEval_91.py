
def precondition(input):
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    return isinstance(output, int) and output >= 0

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
