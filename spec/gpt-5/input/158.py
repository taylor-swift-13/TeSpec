def chars_of_string(s: str) -> list:
    return list(s)

def unique_char_count(s: str, n: int) -> bool:
    return len(set(s)) == n

def _orig_find_max_spec(words: list, output: str) -> bool:
    if not words:
        return output == ''
    if output not in words:
        return False
    n = len(set(output))
    for w in words:
        if len(set(w)) > n:
            return False
    for w in words:
        if len(set(w)) == n:
            if w < output:
                return False
    return True

def find_max_spec(words, output):
    return bool(_orig_find_max_spec(words, output))
