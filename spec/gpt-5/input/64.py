def ascii_eqb(a: str, b: str) -> bool:
    return a == b

def vowelb(c: str) -> bool:
    return c in "aeiouAEIOU"

def yb(c: str) -> bool:
    return c in "yY"

def count_vowels_excluding_y(s: str) -> int:
    return sum(1 for c in s if vowelb(c))

def last_is_y(s: str) -> bool:
    if not s:
        return False
    return yb(s[-1])

def _orig_vowels_count_spec(s: str, n: int) -> bool:
    return n == count_vowels_excluding_y(s) + (1 if last_is_y(s) else 0)

def vowels_count_spec(s, output):
    return bool(_orig_vowels_count_spec(s, output))
