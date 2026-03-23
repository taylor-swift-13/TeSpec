def char_to_bool(c: str) -> bool:
    return c == '1'

def bool_to_char(b: bool) -> str:
    return '1' if b else '0'

def xor_ascii(c1: str, c2: str) -> str:
    return bool_to_char(char_to_bool(c1) ^ char_to_bool(c2))

def string_xor_spec(a: str, b: str, result: str) -> bool:
    if len(result) != len(a):
        return False
    for i in range(len(a)):
        char_a = a[i]
        char_b = b[i] if i < len(b) else '0'
        char_r = result[i]
        if char_r != xor_ascii(char_a, char_b):
            return False
    return True
