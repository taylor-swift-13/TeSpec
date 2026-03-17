
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
    
    # Empty string should return False
    if txt == "":
        return output == False
    
    # If last character is a space, should return False
    if txt[-1] == ' ':
        return output == False
    
    # If last character is not alphabetical, should return False
    if not txt[-1].isalpha():
        return output == False
    
    # Last character is alphabetical
    # Check if it's a single character word (not part of a longer word)
    # Split by space and check if last non-empty segment is single char
    words = txt.split(' ')
    
    # Find the last non-empty word
    last_word = None
    for w in reversed(words):
        if w != '':
            last_word = w
            break
    
    if last_word is None:
        return output == False
    
    # If last word has length 1 and is alphabetical, return True
    # Otherwise return False
    expected = len(last_word) == 1 and last_word.isalpha()
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
