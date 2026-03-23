def is_prime(n: int) -> bool:
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def _orig_problem_82_pre(s: str) -> bool:
    return True

def _orig_problem_82_spec(s: str, b: bool) -> bool:
    return b == is_prime(len(s))

def problem_82_pre(string):
    return bool(_orig_problem_82_pre(string))

def problem_82_spec(string, output):
    return bool(_orig_problem_82_spec(string, output))
