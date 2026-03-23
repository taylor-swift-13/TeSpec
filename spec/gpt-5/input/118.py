def nth_char(n, s):
    if type(n) is not int or n < 0:
        return None
    if type(s) is not str:
        return None
    if n >= len(s):
        return None
    return s[n]

def is_vowel(c):
    if type(c) is not str:
        return False
    return c in ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

def between_consonants(w, i, ch):
    if type(w) is not str:
        return False
    if type(i) is not int or i < 0:
        return False
    if type(ch) is not str:
        return False

    if nth_char(i, w) != ch:
        return False

    if not is_vowel(ch):
        return False

    # In Coq, Nat.pred 0 is 0.
    pred_i = i - 1 if i > 0 else 0
    a = nth_char(pred_i, w)
    if a is None or is_vowel(a):
        return False

    c_next = nth_char(i + 1, w)
    if c_next is None or is_vowel(c_next):
        return False

    return True

def _orig_get_closest_vowel_spec(word, output):
    if type(word) is not str or type(output) is not str:
        return False
    best_ch = None
    for i in range(len(word)):
        ch = word[i]
        if between_consonants(word, i, ch):
            best_ch = ch
    if best_ch is not None:
        return output == best_ch
    else:
        return output == ''

def get_closest_vowel_spec(word, output):
    return bool(_orig_get_closest_vowel_spec(word, output))
