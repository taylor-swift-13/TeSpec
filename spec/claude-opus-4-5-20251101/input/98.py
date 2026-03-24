def is_upper_vowel(c: str) -> bool:
    return c in ("A", "E", "I", "O", "U")

def string_to_list(s: str) -> list:
    return list(s)

def count_upper_vowels_even_indices_aux(l: list, idx: int) -> int:
    if not l:
        return 0
    c = l[0]
    rest = l[1:]
    count_rest = count_upper_vowels_even_indices_aux(rest, idx + 1)
    if idx % 2 == 0:
        if is_upper_vowel(c):
            return 1 + count_rest
        else:
            return count_rest
    else:
        return count_rest

def count_upper_vowels_even_indices(l: list) -> int:
    return count_upper_vowels_even_indices_aux(l, 0)

# Old recursion-based translation:
# def _orig_count_upper_spec(s: str, output: int) -> bool:
#     return output == count_upper_vowels_even_indices(string_to_list(s))
def _orig_count_upper_spec(s: str, output: int) -> bool:
    count = 0
    for idx, ch in enumerate(s):
        if idx % 2 == 0 and is_upper_vowel(ch):
            count += 1
    return output == count

def count_upper_spec(s, output):
    return bool(_orig_count_upper_spec(s, output))
