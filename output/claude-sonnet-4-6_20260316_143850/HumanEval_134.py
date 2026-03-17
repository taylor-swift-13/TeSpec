
def precondition(input):
    if len(input) != 1:
        return False
    txt = input[0]
    if not isinstance(txt, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    txt = input[0]
    if len(txt) == 0:
        return output == False
    last_char = txt[-1]
    if not last_char.isalpha():
        return output == False
    parts = txt.split(' ')
    last_part = parts[-1]
    if len(last_part) == 1 and last_part.isalpha():
        return output == True
    else:
        return output == False

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
