def _orig_problem_92_pre(x, y, z):
    return True

def _orig_problem_92_spec(x, y, z, b):
    try:
        if x != int(x) or y != int(y) or z != int(z):
            cond = False
        else:
            cond = x == y + z or y == x + z or z == x + y
    except Exception:
        cond = False
    return b == cond

def problem_92_pre(x, y, z):
    return bool(_orig_problem_92_pre(x, y, z))

def problem_92_spec(x, y, z, output):
    return bool(_orig_problem_92_spec(x, y, z, output))
