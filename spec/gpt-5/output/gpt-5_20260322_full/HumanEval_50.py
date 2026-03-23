def encode_shift(s: str):
    """
    returns encoded string by shifting every character by 5 in the alphabet.
    """
    return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])

m26 = 26
a_code = 97
e5 = 5

def nat_sub(n: int, m: int) -> int:
    return max(0, n - m)

encode_offset = (nat_sub(e5 + m26, a_code % m26)) % m26
decode_offset = (nat_sub(m26, (a_code % m26) + e5)) % m26

def map_string(f, s: str) -> str:
    return "".join(f(c) for c in s)

def encode_char(c: str) -> str:
    return chr(((ord(c) % m26) + encode_offset) % m26 + a_code)

def decode_char(c: str) -> str:
    return chr(((ord(c) % m26) + decode_offset) % m26 + a_code)

def encode_shift_spec(s: str, t: str) -> bool:
    return t == map_string(encode_char, s)

def decode_shift_spec(s: str, t: str) -> bool:
    return t == map_string(decode_char, s)

def _impl(s: str):
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(decode_shift_spec(*input, output))

def decode_shift(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
