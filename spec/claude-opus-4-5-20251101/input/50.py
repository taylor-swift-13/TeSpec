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

# def decode_shift_spec(s: str, result: str) -> bool:
#     # First conjunct: result = decode_shift s
#     if result != decode_shift(s):
#         return False
#
#     # Second conjunct: forall original : string, encode_shift original = s -> result = original
#     # Since encode_shift preserves string length, any valid original must have the same length.
#     if len(s) != len(result):
#         return False
#
#     # We check the implication character by character.
#     # As per the intended domain of encode_shift, we only consider lowercase letters ('a'-'z')
#     # for the original characters, since characters outside this range are outside the intended domain
#     # and produce spurious results due to modular arithmetic.
#     for s_char, r_char in zip(s, result):
#         for code in range(97, 123):
#             orig_char = chr(code)
#             # IF some valid original character encodes to s_char, THEN it must equal r_char
#             if encode_shift_char(orig_char) == s_char and orig_char != r_char:
#                 return False
#
#     return True

def decode_shift_spec(s: str, result: str) -> bool:
    if result != decode_shift(s):
        return False
    for s_char, r_char in zip(s, result):
        for code in range(256):
            orig_char = chr(code)
            if encode_shift_char(orig_char) == s_char and orig_char != r_char:
                return False
    return True
