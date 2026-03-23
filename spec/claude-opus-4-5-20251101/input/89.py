def is_lowercase(c: str) -> bool:
    n = ord(c)
    return 97 <= n <= 122

def rotate_char(c: str) -> str:
    if is_lowercase(c):
        n = ord(c)
        shifted = (n - 97 + 4) % 26 + 97
        return chr(shifted)
    else:
        return c

def encrypt_aux(s: list) -> list:
    return [rotate_char(c) for c in s]

def string_to_list(s: str) -> list:
    return list(s)

def list_to_string(l: list) -> str:
    return "".join(l)

def _orig_encrypt_spec(s: str, output: str) -> bool:
    return output == list_to_string(encrypt_aux(string_to_list(s)))

def encrypt_spec(s, output):
    return bool(_orig_encrypt_spec(s, output))
