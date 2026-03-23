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
