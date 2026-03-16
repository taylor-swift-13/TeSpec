
def precondition(input):
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(s) != len(output):
        return False
    words_s = s.split(' ')
    words_out = output.split(' ')
    if len(words_s) != len(words_out):
        return False
    for w_s, w_out in zip(words_s, words_out):
        if sorted(w_s) != sorted(w_out):
            return False
        if w_out != ''.join(sorted(w_out)):
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
