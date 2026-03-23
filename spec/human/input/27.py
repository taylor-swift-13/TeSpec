def IsLow(c: str) -> bool:
    return ord('a') <= ord(c) <= ord('z')

def IsUp(c: str) -> bool:
    return ord('A') <= ord(c) <= ord('Z')

def Upper(c: str) -> str:
    if ord('a') <= ord(c) <= ord('z'):
        return chr(ord(c) - 32)
    return c

def Lower(c: str) -> str:
    if ord('A') <= ord(c) <= ord('Z'):
        return chr(ord(c) + 32)
    return c

def _orig_problem_27_pre(input: str) -> bool:
    return True

def _orig_problem_27_spec(input: str, output: str) -> bool:
    if len(input) != len(output):
        return False
    for i in range(len(input)):
        c = input[i]
        out_c = output[i]
        if IsLow(c):
            if out_c != Upper(c):
                return False
        if IsUp(c):
            if out_c != Lower(c):
                return False
        if not IsLow(c) and (not IsUp(c)):
            if out_c != c:
                return False
    return True

def problem_27_pre(string):
    return bool(_orig_problem_27_pre(string))

def problem_27_spec(string, output):
    return bool(_orig_problem_27_spec(string, output))
