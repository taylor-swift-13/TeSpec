
def precondition(input):
    # Input should be a single string argument
    if len(input) != 1:
        return False
    S = input[0]
    if not isinstance(S, str):
        return False
    return True


def postcondition(input, output):
    S = input[0]
    # Output should be a non-negative integer
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    
    # Split by sentence delimiters '.', '?', '!'
    import re
    sentences = re.split(r'[.?!]', S)
    
    # Count sentences that start with "I" (after stripping leading whitespace)
    # A sentence starting with "I" means the first word is "I"
    count = 0
    for sentence in sentences:
        stripped = sentence.lstrip()
        if stripped.startswith('I') and (len(stripped) == 1 or not stripped[1].isalpha()):
            count += 1
    
    if output != count:
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
