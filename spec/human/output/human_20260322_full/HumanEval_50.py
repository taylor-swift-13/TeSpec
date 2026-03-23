def encode_shift(s: str):
    """
    returns encoded string by shifting every character by 5 in the alphabet.
    """
    return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])

def decode_char(c: str) -> str:
    n = ord(c)
    a = ord('a')
    # Coq's nat subtraction truncates at 0
    sub = n - a if n >= a else 0
    # Coq's ascii_of_nat implicitly takes modulo 256, though here the value is always in [97, 122]
    return chr((a + (sub + 21) % 26) % 256)

def problem_50_pre(l_prime: str) -> bool:
    return True

def problem_50_spec(l_prime: str, l: str) -> bool:
    return l == "".join(decode_char(c) for c in l_prime)

def _impl(s: str):
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_50_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_50_spec(*input, output))

def decode_shift(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
