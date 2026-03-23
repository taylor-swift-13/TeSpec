def is_vowel(c: str) -> bool:
    return c in ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']

def count_consonants(w: list) -> int:
    count = 0
    for c in w:
        n = ord(c)
        is_upper = 65 <= n <= 90
        is_lower = 97 <= n <= 122
        is_letter = is_upper or is_lower
        if is_letter and not is_vowel(c):
            count += 1
    return count

def split_words(s: list) -> list:
    res = []
    cur = []
    for c in s:
        if c == ' ':
            if cur:
                res.append(cur)
                cur = []
        else:
            cur.append(c)
    if cur:
        res.append(cur)
    return res

def select_words_impl(s: list, n: int) -> list:
    return [w for w in split_words(s) if count_consonants(w) == n]

def select_words(s: str, n: int) -> list:
    l = list(s)
    res = select_words_impl(l, n)
    return ["".join(w) for w in res]

def problem_117_pre(s: str) -> bool:
    l = list(s)
    for c in l:
        if c == ' ':
            continue
        n = ord(c)
        if (65 <= n <= 90) or (97 <= n <= 122):
            continue
        return False
    return True

def problem_117_spec(s: str, n: int, output: list) -> bool:
    return output == select_words(s, n)
