def is_alpha(c):
    n = ord(c)
    return (65 <= n <= 90) or (97 <= n <= 122)

def check_if_last_char_is_a_letter_spec(txt, res):
    length = len(txt)
    if length == 0:
        return res == False
    elif length == 1:
        return res == is_alpha(txt[0])
    else:
        last_char = txt[length - 1]
        prev_char = txt[length - 2]
        return res == (is_alpha(last_char) and prev_char == ' ')

def _impl(txt):
    if len(txt) == 0: return False
    if len(txt) == 1: return txt.isalpha()
    return txt[-1].isalpha() and txt[-2] == " "

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(check_if_last_char_is_a_letter_spec(*input, output))

def check_if_last_char_is_a_letter(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
