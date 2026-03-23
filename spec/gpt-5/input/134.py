def last_ascii(s: str):
    if not s:
        return None
    return s[-1]

def second_last_ascii(s: str):
    if len(s) < 2:
        return None
    return s[-2]

def is_alpha(c: str) -> bool:
    n = ord(c)
    return (65 <= n <= 90) or (97 <= n <= 122)

def is_space(c: str) -> bool:
    return ord(c) == 32

def _orig_check_if_last_char_is_a_letter_spec(txt: str, output: bool) -> bool:
    n = len(txt)
    if n == 0:
        expected = False
    elif n == 1:
        c = last_ascii(txt)
        if c is not None:
            expected = is_alpha(c)
        else:
            expected = False
    else:
        c = last_ascii(txt)
        p = second_last_ascii(txt)
        if c is not None and p is not None:
            expected = is_alpha(c) and is_space(p)
        else:
            expected = False
    return output == expected

def check_if_last_char_is_a_letter_spec(txt, output):
    return bool(_orig_check_if_last_char_is_a_letter_spec(txt, output))
