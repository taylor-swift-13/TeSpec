
def precondition(input_args: tuple) -> bool:
    return len(input_args) == 1 and isinstance(input_args[0], str)

def postcondition(input_args: tuple, output: bool) -> bool:
    txt = input_args[0]
    if not isinstance(output, bool):
        return False
    
    if len(txt) == 0:
        expected = False
    else:
        last_char = txt[-1]
        is_alpha = last_char.isalpha()
        # A character is not part of a word if it is preceded by a space 
        # or if it is the only character in the string.
        is_standalone = len(txt) == 1 or txt[-2] == ' '
        expected = is_alpha and is_standalone
        
    return output == expected

def _impl(txt):
    """Create a function that returns True if the last character
    of a given string is an alphabetical character and is not
    a part of a word, and False otherwise.
    Note: "word" is a group of characters separated by space.

    Examples:
    check_if_last_char_is_a_letter("apple pie") ➞ False
    check_if_last_char_is_a_letter("apple pi e") ➞ True
    check_if_last_char_is_a_letter("apple pi e ") ➞ False
    check_if_last_char_is_a_letter("") ➞ False"""
    if len(txt) == 0: return False
    if len(txt) == 1: return txt.isalpha()
    return txt[-1].isalpha() and txt[-2] == " "

def check_if_last_char_is_a_letter(txt):
    _input = (txt,)
    assert precondition(_input)
    _output = _impl(txt)
    assert postcondition(_input, _output)
    return _output
