a_code = 97

z_code = 122

def is_lowercase_ascii(c: str) -> bool:
    n = ord(c)
    return a_code <= n and n <= z_code

def rot4_ascii(c: str) -> str:
    n = ord(c)
    if is_lowercase_ascii(c):
        return chr(a_code + ((n - a_code + 4) % 26))
    else:
        return c

def map_string(f, s: str) -> str:
    return "".join(f(c) for c in s)

def _orig_encrypt_spec(s: str, output: str) -> bool:
    return output == map_string(rot4_ascii, s)

def encrypt_spec(s, output):
    return bool(_orig_encrypt_spec(s, output))
