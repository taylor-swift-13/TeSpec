def is_alpha(c):
    n = ord(c)
    return (65 <= n <= 90) or (97 <= n <= 122)

def _orig_check_if_last_char_is_a_letter_spec(txt, output):
    length = len(txt)
    if length == 0:
        return output == False
    elif length == 1:
        return output == is_alpha(txt[0])
    else:
        last_char = txt[length - 1]
        prev_char = txt[length - 2]
        return output == (is_alpha(last_char) and prev_char == ' ')

def check_if_last_char_is_a_letter_spec(txt, output):
    return bool(_orig_check_if_last_char_is_a_letter_spec(txt, output))
