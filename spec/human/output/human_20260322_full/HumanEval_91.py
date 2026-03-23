def is_sentence_delimiter(c: str) -> bool:
    return c in ['.', '?', '!']

def split_aux(p, s: str, current: str) -> list:
    res = []
    curr = current
    for c in s:
        if p(c):
            res.append(curr)
            curr = ""
        else:
            curr += c
    res.append(curr)
    return res

def split(p, s: str) -> list:
    return split_aux(p, s, "")

def is_whitespace(c: str) -> bool:
    return c == " "

def trim_leading_whitespace(s: str) -> str:
    for i, c in enumerate(s):
        if not is_whitespace(c):
            return s[i:]
    return ""

def prefix(p: str, s: str) -> bool:
    return s.startswith(p)

def is_boredom_sentence_new(s: str) -> bool:
    return prefix("I", s)

def is_bored_impl(S: str) -> int:
    initial = split(is_sentence_delimiter, S)
    cleaned = [trim_leading_whitespace(s) for s in initial]
    boredoms = [s for s in cleaned if is_boredom_sentence_new(s)]
    return len(boredoms)

def problem_91_pre(S: str) -> bool:
    return True

def problem_91_spec(S: str, output: int) -> bool:
    return output == is_bored_impl(S)

def _impl(S):
    sentences = map(lambda x: x.strip(), ((S.replace("?", ".")).replace("!", ".")).split("."))
    return len([s for s in sentences if s.startswith("I ")])

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_91_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_91_spec(*input, output))

def is_bored(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
