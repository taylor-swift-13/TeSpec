def InStr(a: str, s: str) -> bool:
    return a in s

def same_char_sets(s0: str, s1: str) -> bool:
    return set(s0) == set(s1)

def _orig_same_chars_spec(s0: str, s1: str, output: bool) -> bool:
    return output == same_char_sets(s0, s1)

def same_chars_spec(s0, s1, output):
    return bool(_orig_same_chars_spec(s0, s1, output))
