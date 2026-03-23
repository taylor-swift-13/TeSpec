def is_vowel(ch: str) -> bool:
    return ch in "aeiouAEIOU"

def is_y(ch: str) -> bool:
    return ch in "yY"

def string_to_list(s: str) -> list:
    return list(s)

def count_vowels_in_list(l: list) -> int:
    return sum(1 for c in l if is_vowel(c))

def last_char(s: str):
    if not s:
        return None
    return s[-1]

def ends_with_y(s: str) -> bool:
    c = last_char(s)
    if c is None:
        return False
    return is_y(c)

def _orig_vowels_count_spec(s: str, output: int) -> bool:
    base_count = count_vowels_in_list(string_to_list(s))
    y_bonus = 1 if ends_with_y(s) else 0
    return output == base_count + y_bonus

def vowels_count_spec(s, output):
    return bool(_orig_vowels_count_spec(s, output))
