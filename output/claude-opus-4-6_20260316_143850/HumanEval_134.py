
def precondition(input):
    (txt,) = input
    return isinstance(txt, str)

def postcondition(input, output):
    (txt,) = input
    if not isinstance(output, bool):
        return False
    if txt == "":
        return output == False
    # Last character must be alphabetical and must be a single-character "word"
    # (i.e., preceded by a space or is the only character)
    last_char = txt[-1]
    if not last_char.isalpha():
        return output == False
    # Check if the last character is a standalone letter (not part of a longer word)
    # Split by space and check if the last word has length 1
    words = txt.split(" ")
    last_word = words[-1]
    expected = (len(last_word) == 1 and last_word.isalpha())
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
