def factorial(n):
    """
    Calculates the factorial of a natural number n.
    Coq: Fixpoint factorial (n : nat) : Z
    """
    if n == 0:
        return 1
    res = 1
    for i in range(1, n + 1):
        res *= i
    return res

def brazilian_factorial(n):
    """
    Calculates the product of factorials from 1 to n.
    Coq: Fixpoint brazilian_factorial (n : nat) : Z
    """
    if n == 0:
        return 1
    res = 1
    for i in range(1, n + 1):
        res *= factorial(i)
    return res

def _orig_special_factorial_spec(n, output):
    """
    Checks if n > 0 and output is equal to the brazilian_factorial of n.
    Coq: Definition special_factorial_spec (n : Z) (output : Z) : Prop
    """
    if not n > 0:
        return False
    return output == brazilian_factorial(int(n))

def special_factorial_spec(n, output):
    return bool(_orig_special_factorial_spec(n, output))
