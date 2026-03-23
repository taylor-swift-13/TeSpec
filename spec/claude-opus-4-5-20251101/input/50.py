import builtins

def ord(ch: str) -> int:
    return builtins.ord(ch)

def chr(n: int) -> str:
    return builtins.chr(n)

ord_a = ord('a')

def encode_shift_char(ch: str) -> str:
    return chr(((ord(ch) + 5 - ord_a) % 26) + ord_a)

def decode_shift_char(ch: str) -> str:
    return chr(((ord(ch) - ord_a - 5 + 26) % 26) + ord_a)

def string_to_list(s: str) -> list:
    return list(s)

def list_to_string(l: list) -> str:
    return "".join(l)

def encode_shift(s: str) -> str:
    return list_to_string([encode_shift_char(c) for c in string_to_list(s)])

def decode_shift(s: str) -> str:
    return list_to_string([decode_shift_char(c) for c in string_to_list(s)])

def _orig_decode_shift_spec(s: str, output: str) -> bool:
    if output != decode_shift(s):
        return False
    for (s_char, r_char) in zip(s, output):
        for code in range(256):
            orig_char = chr(code)
            if encode_shift_char(orig_char) == s_char and orig_char != r_char:
                return False
    return True

def decode_shift_spec(s, output):
    return bool(_orig_decode_shift_spec(s, output))
