def is_standard_vowel(c: str) -> bool:
    return c in ("a", "e", "i", "o", "u", "A", "E", "I", "O", "U")

def count_standard_vowels(s: str) -> int:
    return sum(1 for c in s if is_standard_vowel(c))

def is_y(c: str) -> bool:
    return c in ("y", "Y")

def last_char_is_y(s: str) -> bool:
    if len(s) == 0:
        return False
    return is_y(s[-1])

def _orig_vowels_count_spec(s: str, cnt: int) -> bool:
    return cnt == count_standard_vowels(s) + (1 if last_char_is_y(s) else 0)

def vowels_count_spec(s, output):
    return bool(_orig_vowels_count_spec(s, output))
