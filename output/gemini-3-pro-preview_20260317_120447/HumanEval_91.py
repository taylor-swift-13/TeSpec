
def precondition(input_args: tuple) -> bool:
    return len(input_args) == 1 and isinstance(input_args[0], str)

def postcondition(input_args: tuple, output: int) -> bool:
    if not isinstance(output, int) or output < 0:
        return False
    
    s = input_args[0]
    import re
    # Split the string by the delimiters '.', '?', and '!'
    sentences = re.split(r'[.?!]', s)
    
    count = 0
    for sentence in sentences:
        # Remove leading and trailing whitespace
        trimmed = sentence.strip()
        # Check if the sentence starts with the word "I"
        # A word "I" means it is either the whole sentence or followed by a space
        words = trimmed.split()
        if words and words[0] == "I":
            count += 1
            
    return output == count

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
