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

def _orig_encrypt_spec(s: str, output: str) -> bool:
    return output == encrypt_model(s)

def encrypt_spec(s, output):
    return bool(_orig_encrypt_spec(s, output))
