ord_a = 97

def encode_char_op(c):
    char_code = ord(c)
    encoded_code = ((char_code + 5 - ord_a) % 26) + ord_a
    return chr(encoded_code)

def decode_char_op(c):
    char_code = ord(c)
    decoded_code = ((char_code - ord_a - 5 + 26) % 26) + ord_a
    return chr(decoded_code)

def encode_shift_spec(s, output):
    mapped_s = "".join(encode_char_op(c) for c in s)
    return output == mapped_s

def _orig_decode_shift_spec(s, output):
    mapped_s = ''.join((decode_char_op(c) for c in s))
    return output == mapped_s

def decode_shift_spec(s, output):
    return bool(_orig_decode_shift_spec(s, output))
