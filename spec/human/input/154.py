def list_ascii_of_string(s: str) -> list:
    return list(s)

def is_substring(sub: list, main: list) -> bool:
    n = len(sub)
    for i in range(len(main) - n + 1):
        if main[i:i+n] == sub:
            return True
    return False

def is_rotation_of(r: list, b: list) -> bool:
    if len(r) != len(b):
        return False
    for i in range(len(b) + 1):
        if r == b[i:] + b[:i]:
            return True
    return False

def problem_154_pre(a: str, b: str) -> bool:
    return True

def problem_154_spec(a: str, b: str, res: bool) -> bool:
    la = list_ascii_of_string(a)
    lb = list_ascii_of_string(b)
    
    exists_b_prime = False
    for i in range(len(lb) + 1):
        b_prime = lb[i:] + lb[:i]
        if is_substring(b_prime, la):
            exists_b_prime = True
            break
            
    return res == exists_b_prime
