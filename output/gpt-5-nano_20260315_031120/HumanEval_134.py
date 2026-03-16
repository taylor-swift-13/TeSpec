
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    if not isinstance(input[0], str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1 or not isinstance(input[0], str):
        return False
    if not isinstance(output, bool):
        return False

    s = input[0]
    if len(s) == 0:
        expected = False
    else:
        if not s[-1].isalpha():
            expected = False
        else:
            last_space = s.rfind(' ')
            if last_space == -1:
                last_token_len = len(s)
            else:
                last_token_len = len(s) - last_space - 1
            expected = (last_token_len == 1)
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
