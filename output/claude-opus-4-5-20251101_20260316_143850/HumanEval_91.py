
def precondition(input):
    if len(input) != 1:
        return False
    S = input[0]
    if not isinstance(S, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    S = input[0]
    # Count sentences by counting delimiters
    sentence_count = S.count('.') + S.count('?') + S.count('!')
    # If there's content but no delimiters, there could be at most 1 sentence
    if sentence_count == 0:
        if output > 1:
            return False
    else:
        # Output cannot exceed number of sentences
        if output > sentence_count:
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
