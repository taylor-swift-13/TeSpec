def encode_shift(s: str):
    """
    returns encoded string by shifting every character by 5 in the alphabet.
    """
    return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])

ord_a = 97

def encode_char_op(c):
    char_code = ord(c)
    encoded_code = ((char_code + 5 - ord_a) % 26) + ord_a
    return chr(encoded_code)

def decode_char_op(c):
    char_code = ord(c)
    decoded_code = ((char_code - ord_a - 5 + 26) % 26) + ord_a
    return chr(decoded_code)

def encode_shift_spec(s, result):
    mapped_s = "".join(encode_char_op(c) for c in s)
    return result == mapped_s

def decode_shift_spec(s, result):
    mapped_s = "".join(decode_char_op(c) for c in s)
    return result == mapped_s

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
