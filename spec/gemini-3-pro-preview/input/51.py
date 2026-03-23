def is_vowel(c: str) -> bool:
    return c in ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

def _orig_remove_vowels_spec(text: str, output: str) -> bool:
    expected = ''.join((c for c in text if not is_vowel(c)))
    return output == expected

def remove_vowels_spec(text, output):
    return bool(_orig_remove_vowels_spec(text, output))
