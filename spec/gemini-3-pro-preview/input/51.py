def is_vowel(c: str) -> bool:
    return c in ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

def remove_vowels_spec(text: str, result: str) -> bool:
    expected = "".join(c for c in text if not is_vowel(c))
    return result == expected
