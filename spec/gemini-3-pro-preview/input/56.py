def correct_bracketing_aux(l, cnt):
    for c in l:
        if c == '<':
            cnt += 1
        elif c == '>':
            cnt -= 1
        if cnt < 0:
            return False
    return cnt == 0

def _orig_correct_bracketing_spec(brackets, output):
    return output == correct_bracketing_aux(list(brackets), 0)

def correct_bracketing_spec(brackets, output):
    return bool(_orig_correct_bracketing_spec(brackets, output))
