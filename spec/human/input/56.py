def correct_bracketing_aux(s: str, depth: int) -> bool:
    for c in s:
        if c == '<':
            depth += 1
        elif c == '>':
            if depth == 0:
                return False
            depth -= 1
    return depth == 0

def correct_bracketing(s: str) -> bool:
    return correct_bracketing_aux(s, 0)

def problem_56_pre(brackets: str) -> bool:
    return all(c == '<' or c == '>' for c in brackets)

def problem_56_spec(brackets: str, b: bool) -> bool:
    return b == correct_bracketing(brackets)
