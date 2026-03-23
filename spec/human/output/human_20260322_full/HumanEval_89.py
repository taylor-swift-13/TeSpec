def char_relation(c_in: str, c_out: str) -> bool:
    mapping = {
        "a": "e", "b": "f", "c": "g", "d": "h",
        "e": "i", "f": "j", "g": "k", "h": "l",
        "i": "m", "j": "n", "k": "o", "l": "p",
        "m": "q", "n": "r", "o": "s", "p": "t",
        "q": "u", "r": "v", "s": "w", "t": "x",
        "u": "y", "v": "z", "w": "a", "x": "b",
        "y": "c", "z": "d"
    }
    if c_in in mapping:
        return c_out == mapping[c_in]
    else:
        return c_out == c_in

def problem_89_pre(s: str) -> bool:
    return True

def problem_89_spec(s: str, output: str) -> bool:
    if len(s) != len(output):
        return False
    for i in range(len(s)):
        if not char_relation(s[i], output[i]):
            return False
    return True

def _impl(s):
    d = 'abcdefghijklmnopqrstuvwxyz'
    return "".join(map(lambda ch: chr((ord(ch) - ord("a") + 4) % 26 + ord("a")) if ch in d else ch, s))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_89_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_89_spec(*input, output))

def encrypt(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
