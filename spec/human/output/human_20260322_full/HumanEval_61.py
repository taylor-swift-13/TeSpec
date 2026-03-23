def correct_bracketing_aux(s: str, depth: int) -> bool:
    for c in s:
        if c == '(':
            depth += 1
        elif c == ')':
            if depth == 0:
                return False
            depth -= 1
    return depth == 0

def correct_bracketing(s: str) -> bool:
    return correct_bracketing_aux(s, 0)

def problem_61_pre(brackets: str) -> bool:
    return all(c == '(' or c == ')' for c in brackets)

def problem_61_spec(brackets: str, output: bool) -> bool:
    return output == correct_bracketing(brackets)

def _impl(brackets: str):
    cnt = 0
    for x in brackets:
        if x == "(": cnt += 1
        if x == ")": cnt -= 1
        if cnt < 0: return False
    return cnt == 0

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_61_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_61_spec(*input, output))

def correct_bracketing(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
