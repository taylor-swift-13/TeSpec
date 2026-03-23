def decode_char(c: str) -> str:
    n = ord(c)
    a = ord('a')
    # Coq's nat subtraction truncates at 0
    sub = n - a if n >= a else 0
    # Coq's ascii_of_nat implicitly takes modulo 256, though here the value is always in [97, 122]
    return chr((a + (sub + 21) % 26) % 256)

def _orig_problem_50_pre(l_prime: str) -> bool:
    return True

def _orig_problem_50_spec(l_prime: str, l: str) -> bool:
    return l == ''.join((decode_char(c) for c in l_prime))

def problem_50_pre(s):
    return bool(_orig_problem_50_pre(s))

def problem_50_spec(s, output):
    return bool(_orig_problem_50_spec(s, output))
