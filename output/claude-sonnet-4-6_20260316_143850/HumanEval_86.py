
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    s = input[0]
    
    # Check same number of words (split by space, keeping spaces)
    input_parts = s.split(' ')
    output_parts = output.split(' ')
    
    if len(input_parts) != len(output_parts):
        return False
    
    # Each word in output should be sorted version of corresponding input word
    for in_word, out_word in zip(input_parts, output_parts):
        if sorted(in_word) != sorted(out_word):
            return False
        if list(out_word) != sorted(out_word):
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
