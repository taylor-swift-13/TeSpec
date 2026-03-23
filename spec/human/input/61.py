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

def _orig_problem_61_pre(brackets: str) -> bool:
    return all((c == '(' or c == ')' for c in brackets))

def _orig_problem_61_spec(brackets: str, output: bool) -> bool:
    return output == correct_bracketing(brackets)

def problem_61_pre(brackets):
    return bool(_orig_problem_61_pre(brackets))

def problem_61_spec(brackets, output):
    return bool(_orig_problem_61_spec(brackets, output))
