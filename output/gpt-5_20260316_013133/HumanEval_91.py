
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not (isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)):
        return False
    S = input[0]
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # Upper bound: number of potential sentence segments is at most number of delimiters + 1
    num_segments_upper = S.count('.') + S.count('?') + S.count('!') + 1
    if output > num_segments_upper:
        return False
    # If there's no 'I' at all, there can be no boredom
    if 'I' not in S and output != 0:
        return False
    # Upper bound: number of 'I' words in the entire string
    n = len(S)
    count_I_words = 0
    i = 0
    while True:
        idx = S.find('I', i)
        if idx == -1:
            break
        left_ok = (idx == 0) or (not S[idx - 1].isalpha())
        right_ok = (idx + 1 == n) or (not S[idx + 1].isalpha())
        if left_ok and right_ok:
            count_I_words += 1
        i = idx + 1
    if output > count_I_words:
        return False
    return True

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
