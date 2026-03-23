def is_upper(a: str) -> bool:
    n = ord(a)
    return 65 <= n <= 90

def lower(a: str) -> str:
    if is_upper(a):
        return chr(ord(a) + 32)
    return a

def problem_16_pre(s: str) -> bool:
    return True

def problem_16_spec(s: str, output: int) -> bool:
    D = set()
    for char in s:
        D.add(lower(char))
    return output == len(D)
