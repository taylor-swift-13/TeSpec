
def precondition(input):
    (s,) = input
    if not isinstance(s, str):
        return False
    return True


def postcondition(input, output):
    (s,) = input
    if not isinstance(output, str):
        return False
    # The output should have the same length as the input
    if len(output) != len(s):
        return False
    # Split by spaces preserving structure: same number of words
    input_words = s.split(' ')
    output_words = output.split(' ')
    if len(input_words) != len(output_words):
        return False
    # Each output word should be a sorted version of the corresponding input word
    for iw, ow in zip(input_words, output_words):
        if len(iw) != len(ow):
            return False
        if sorted(iw) != list(ow):
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
