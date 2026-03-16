
def precondition(input):
    S, = input
    return isinstance(S, str)

def postcondition(input, output):
    S, = input
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    
    # Conservative check: output shouldn't exceed number of sentences
    sentences = []
    current = []
    for char in S:
        if char in '.?!':
            sentences.append(''.join(current).strip())
            current = []
        else:
            current.append(char)
    if current:
        sentences.append(''.join(current).strip())
    
    # Count sentences starting with "I" (case-sensitive)
    max_possible = 0
    for sent in sentences:
        if sent.startswith('I '):
            max_possible += 1
        elif sent == 'I':
            max_possible += 1
    
    return output <= max_possible

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
