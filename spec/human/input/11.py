def _orig_problem_11_pre(a: str, b: str) -> bool:
    if len(a) != len(b):
        return False
    for i in range(len(a)):
        if a[i] not in ('0', '1') or b[i] not in ('0', '1'):
            return False
    return True

def _orig_problem_11_spec(a: str, b: str, output: str) -> bool:
    if len(a) != len(b):
        return False
    if len(output) != len(a):
        return False
    for i in range(len(output)):
        if a[i] == b[i]:
            if output[i] != '0':
                return False
        elif output[i] != '1':
            return False
    return True

def problem_11_pre(a, b):
    return bool(_orig_problem_11_pre(a, b))

def problem_11_spec(a, b, output):
    return bool(_orig_problem_11_spec(a, b, output))
