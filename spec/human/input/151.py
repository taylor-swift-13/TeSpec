def problem_151_pre(l):
    return True

def problem_151_spec(l, res):
    acc = 0
    for h in l:
        if h >= 0 and h % 2 != 0:
            acc += h * h
    return res == acc
