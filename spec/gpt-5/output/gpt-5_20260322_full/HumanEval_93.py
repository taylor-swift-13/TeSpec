def uppercaseb(n):
    return 65 <= n <= 90

def lowercaseb(n):
    return 97 <= n <= 122

def swap_case(c):
    n = ord(c)
    if uppercaseb(n):
        return chr(n + 32)
    elif lowercaseb(n):
        return chr(n - 32)
    else:
        return c

def vowelb(n):
    return (n == 65 or n == 69 or n == 73 or n == 79 or n == 85 or
            n == 97 or n == 101 or n == 105 or n == 111 or n == 117)

def vowel_change(c):
    n = ord(c)
    if vowelb(n):
        return chr(n + 2)
    else:
        return c

def encode_char(c):
    return vowel_change(swap_case(c))

def string_map(f, s):
    return "".join(f(c) for c in s)

def encode_fun(message):
    return string_map(encode_char, message)

def encode_spec(message, encoded):
    return encoded == encode_fun(message)

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
