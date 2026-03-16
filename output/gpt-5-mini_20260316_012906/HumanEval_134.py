
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    txt = input[0]
    return isinstance(txt, str)

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, bool):
        return False
    txt = input[0]
    if len(txt) == 0:
        expected = False
    else:
        last_char_is_alpha = txt[-1].isalpha()
        prev_is_space_or_start = (len(txt) == 1) or (txt[-2] == " ")
        expected = last_char_is_alpha and prev_is_space_or_start
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
