def is_uppercase(ch: str) -> bool:
    n = ord(ch)
    return 65 <= n <= 90

def is_lowercase(ch: str) -> bool:
    n = ord(ch)
    return 97 <= n <= 122

def switch_case(ch: str) -> str:
    n = ord(ch)
    if is_uppercase(ch):
        return chr(n + 32)
    elif is_lowercase(ch):
        return chr(n - 32)
    else:
        return ch

def is_vowel(ch: str) -> bool:
    n = ord(ch)
    return n in (97, 101, 105, 111, 117, 65, 69, 73, 79, 85)

def vowel_change(ch: str) -> str:
    if is_vowel(ch):
        return chr(ord(ch) + 2)
    else:
        return ch

def encode_char(ch: str) -> str:
    return vowel_change(switch_case(ch))

def encode_list(l: list) -> list:
    return [encode_char(ch) for ch in l]

def encode_spec(message: str, encoded: str) -> bool:
    message_list = list(message)
    encoded_list = encode_list(message_list)
    return encoded == "".join(encoded_list)

def _impl(message):
    def switch_case(ch):
        if ord("A") <= ord(ch) <= ord("Z"):
            return chr(ord(ch) + 32)
        elif ord("a") <= ord(ch) <= ord("z"):
            return chr(ord(ch) - 32)
        else:
            return ch
    def vowel_change(ch):
        return ch if ch not in "aeiouAEIOU" else chr(ord(ch) + 2)
    m = "".join(map(switch_case, message))
    return "".join(map(vowel_change, m))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(encode_spec(*input, output))

def encode(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
