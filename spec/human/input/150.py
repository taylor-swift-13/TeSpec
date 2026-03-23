import math

def is_prime(n):
    """
    Helper function to determine if a number n is prime.
    Corresponds to Coq's prime (Z.of_nat n).
    """
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    # Check for odd factors from 3 up to sqrt(n)
    limit = int(math.isqrt(n))
    for i in range(3, limit + 1, 2):
        if n % i == 0:
            return False
    return True

def _orig_problem_150_pre(n, x, y):
    """
    Precondition for the problem.
    Corresponds to: Definition problem_150_pre (n x y : nat) : Prop := True.
    """
    return True

def _orig_problem_150_spec(n, x, y, output):
    """
    Specification for the problem.
    Corresponds to:
    Definition problem_150_spec (n x y output : nat) : Prop :=
      (prime (Z.of_nat n) -> output = x) /      (~ prime (Z.of_nat n) -> output = y).
    """
    if is_prime(n):
        return output == x
    else:
        return output == y

def problem_150_pre(n, x, y):
    return bool(_orig_problem_150_pre(n, x, y))

def problem_150_spec(n, x, y, output):
    return bool(_orig_problem_150_spec(n, x, y, output))
