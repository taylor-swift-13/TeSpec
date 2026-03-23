def ascii_lower(a: str) -> str:
    n = ord(a)
    if 65 <= n <= 90:
        return chr(n + 32)
    return a

def list_of_string(s: str) -> list:
    return list(s)

def _orig_count_distinct_characters_spec(s: str, n: int) -> bool:
    L = [ascii_lower(x) for x in list_of_string(s)]
    U = set(L)
    return len(U) == n

def count_distinct_characters_spec(string, output):
    return bool(_orig_count_distinct_characters_spec(string, output))
