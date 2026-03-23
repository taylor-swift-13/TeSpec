def is_lower(c: str) -> bool:
    n = ord(c)
    return 97 <= n <= 122

def is_upper(c: str) -> bool:
    n = ord(c)
    return 65 <= n <= 90

def flip_char(c: str) -> str:
    if is_lower(c):
        return chr(ord(c) - 32)
    elif is_upper(c):
        return chr(ord(c) + 32)
    else:
        return c

def flip_case_model(s: str) -> str:
    return "".join(flip_char(c) for c in s)

def _orig_flip_case_spec(s: str, output: str) -> bool:
    return output == flip_case_model(s)

def flip_case_spec(string, output):
    return bool(_orig_flip_case_spec(string, output))
