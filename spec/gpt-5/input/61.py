def correct_bracketing_aux(s: str, cnt: int) -> bool:
    for c in s:
        if c == '(':
            cnt += 1
        elif c == ')':
            cnt -= 1
        if cnt < 0:
            return False
    return cnt == 0

def correct_bracketing_fun(brackets: str) -> bool:
    return correct_bracketing_aux(brackets, 0)

def _orig_correct_bracketing_spec(brackets: str, output: bool) -> bool:
    return output == correct_bracketing_fun(brackets)

def correct_bracketing_spec(brackets, output):
    return bool(_orig_correct_bracketing_spec(brackets, output))
