def is_uppercase(c: str) -> bool:
    """
    Checks if a character is an uppercase ASCII character (ASCII 65-90).
    """
    if not c:
        return False
    n = ord(c)
    # Nat.leb 65 n && Nat.leb n 90
    return 65 <= n <= 90

def sum_uppercase_ascii(s: str) -> int:
    """
    Iterates through the string and sums the ASCII values of uppercase characters.
    """
    total = 0
    for c in s:
        if is_uppercase(c):
            total += ord(c)
    return total

def digitSum_impl(s: str) -> int:
    """
    Main implementation of the digitSum task.
    """
    return sum_uppercase_ascii(s)

def _orig_problem_66_pre(s: str) -> bool:
    """
    Precondition for problem 66.
    """
    return True

def _orig_problem_66_spec(s: str, output: int) -> bool:
    """
    Specification for problem 66: the output must match the result of digitSum_impl.
    """
    return output == digitSum_impl(s)

def problem_66_pre(s):
    return bool(_orig_problem_66_pre(s))

def problem_66_spec(s, output):
    return bool(_orig_problem_66_spec(s, output))
