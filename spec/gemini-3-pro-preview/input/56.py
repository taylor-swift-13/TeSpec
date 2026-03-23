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
