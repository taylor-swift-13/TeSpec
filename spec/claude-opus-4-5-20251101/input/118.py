def is_vowel(ch: str) -> bool:
    return ch in "aeiouAEIOU"

def is_consonant(ch: str) -> bool:
    return not is_vowel(ch)

def string_to_list(s: str) -> list:
    return list(s)

def string_length(s: str) -> int:
    return len(s)

def nth_char(s: str, n: int):
    if 0 <= n < len(s):
        return s[n]
    return None

def valid_vowel_position(word: str, i: int) -> bool:
    chars = string_to_list(word)
    length = len(chars)
    if i > 0 and i < length - 1:
        ch_prev = chars[i - 1]
        ch = chars[i]
        ch_next = chars[i + 1]
        return is_vowel(ch) and is_consonant(ch_prev) and is_consonant(ch_next)
    return False

def no_valid_vowel_after(word: str, i: int) -> bool:
    length = string_length(word)
    for j in range(i + 1, length - 1):
        if valid_vowel_position(word, j):
            return False
    return True

def get_closest_vowel_spec(word: str, result: str) -> bool:
    length = string_length(word)
    if length < 3:
        return result == ""
    
    last_valid_i = -1
    for i in range(1, length - 1):
        if valid_vowel_position(word, i):
            last_valid_i = i
            
    if last_valid_i != -1:
        ch = nth_char(word, last_valid_i)
        return result == ch
    else:
        return result == ""
