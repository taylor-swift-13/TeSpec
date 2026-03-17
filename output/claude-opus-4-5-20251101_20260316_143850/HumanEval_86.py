
def precondition(input):
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    s = input[0]
    
    # Output should have the same length as input
    if len(output) != len(s):
        return False
    
    # Split by spaces while preserving structure
    # Find positions of spaces in input and output - they should match
    input_space_positions = [i for i, c in enumerate(s) if c == ' ']
    output_space_positions = [i for i, c in enumerate(output) if c == ' ']
    if input_space_positions != output_space_positions:
        return False
    
    # Split into words (by space)
    input_words = s.split(' ')
    output_words = output.split(' ')
    
    # Same number of words
    if len(input_words) != len(output_words):
        return False
    
    # Each output word should be a sorted version of the corresponding input word
    for in_word, out_word in zip(input_words, output_words):
        # Same length
        if len(in_word) != len(out_word):
            return False
        # Same characters (sorted input should equal output)
        if sorted(in_word) != list(out_word):
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
