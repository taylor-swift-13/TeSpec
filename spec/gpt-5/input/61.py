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

def correct_bracketing_spec(brackets: str, res: bool) -> bool:
    return res == correct_bracketing_fun(brackets)
