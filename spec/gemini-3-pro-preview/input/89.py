def is_lowercase(c: str) -> bool:
    n = ord(c)
    return 97 <= n <= 122

def rotate_char(c: str) -> str:
    if is_lowercase(c):
        n = ord(c)
        return chr(97 + (n - 97 + 4) % 26)
    else:
        return c

def encrypt_model(s: str) -> str:
    return "".join(rotate_char(c) for c in s)

def encrypt_spec(s: str, result: str) -> bool:
    return result == encrypt_model(s)
