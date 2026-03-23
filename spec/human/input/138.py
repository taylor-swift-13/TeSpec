def is_positive_even(e: int) -> bool:
    return e > 0 and e % 2 == 0

def problem_138_pre(n: int) -> bool:
    return True

def problem_138_spec(n: int, b: bool) -> bool:
    # A number can be written as the sum of exactly 4 positive even numbers
    # if and only if it is even and at least 2 + 2 + 2 + 2 = 8.
    expected = (n >= 8 and n % 2 == 0)
    return b == expected
