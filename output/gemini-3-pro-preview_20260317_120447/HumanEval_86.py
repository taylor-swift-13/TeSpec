
def precondition(input_args):
    if len(input_args) != 1:
        return False
    s = input_args[0]
    return isinstance(s, str)

def postcondition(input_args, output):
    if not isinstance(output, str):
        return False
    s = input_args[0]
    if len(s) != len(output):
        return False
    
    s_parts = s.split(' ')
    o_parts = output.split(' ')
    
    if len(s_parts) != len(o_parts):
        return False
        
    for sp, op in zip(s_parts, o_parts):
        if "".join(sorted(list(sp))) != op:
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
