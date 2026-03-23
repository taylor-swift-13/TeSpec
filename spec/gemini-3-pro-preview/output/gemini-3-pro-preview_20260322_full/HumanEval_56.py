def correct_bracketing_aux(l, cnt):
    for c in l:
        if c == '<':
            cnt += 1
        elif c == '>':
            cnt -= 1
        if cnt < 0:
            return False
    return cnt == 0

def correct_bracketing_spec(brackets, res):
    return res == correct_bracketing_aux(list(brackets), 0)

def _impl(brackets: str):
    cnt = 0
    for x in brackets:
        if x == "<": cnt += 1
        if x == ">": cnt -= 1
        if cnt < 0: return False
    return cnt == 0

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(correct_bracketing_spec(*input, output))

def correct_bracketing(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
