def problem_49_pre(n, p):
    return n >= 0 and p > 0

def problem_49_spec(n, p, output):
    if n >= 0 and p > 0:
        return output == pow(2, n, p)
    return True
