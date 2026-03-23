def char_string(c: str) -> str:
    return c

def sep_char(c: str) -> bool:
    return c == " " or c == ","

def not_sep_char(c: str) -> bool:
    return not sep_char(c)

def all_chars(P, s: str) -> bool:
    for c in s:
        if not P(c):
            return False
    return True

def only_seps(s: str) -> bool:
    return all_chars(sep_char, s)

def word(s: str) -> bool:
    return len(s) > 0 and all_chars(not_sep_char, s)

def components(comps: list, words: list) -> bool:
    if len(comps) == 1 and len(words) == 0:
        return only_seps(comps[0])
    if len(comps) >= 2 and len(words) >= 1:
        sep = comps[0]
        w = comps[1]
        rest = comps[2:]
        if only_seps(sep) and word(w) and words[0] == w:
            return components(rest, words[1:])
    return False

def concat(xs: list) -> str:
    return "".join(xs)

def words_string_spec(s: str, out: list) -> bool:
    for w in out:
        if not word(w):
            return False
    
    s_idx = 0
    for w in out:
        while s_idx < len(s) and sep_char(s[s_idx]):
            s_idx += 1
        if s[s_idx:s_idx+len(w)] != w:
            return False
        s_idx += len(w)
        
    while s_idx < len(s):
        if not sep_char(s[s_idx]):
            return False
        s_idx += 1
        
    return True

def _impl(s):
    words = (s.replace(",", " ")).split()
    return [word for word in words if word != ""]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(words_string_spec(*input, output))

def words_string(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
