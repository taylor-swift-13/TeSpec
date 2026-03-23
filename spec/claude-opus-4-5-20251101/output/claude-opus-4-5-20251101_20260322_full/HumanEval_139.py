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

def special_factorial_spec(n, result):
    """
    Checks if n > 0 and result is equal to the brazilian_factorial of n.
    Coq: Definition special_factorial_spec (n : Z) (result : Z) : Prop
    """
    # n > 0 /\ result = brazilian_factorial (Z.to_nat n)
    if not (n > 0):
        return False
    
    # In Coq, Z.to_nat n for n > 0 is the natural number representation of n.
    # We use int(n) in Python to represent the nat argument.
    return result == brazilian_factorial(int(n))

def _impl(n):
    fac, ans = 1, 1
    for i in range(2, n + 1):
        fac *= i
        ans *= fac
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(special_factorial_spec(*input, output))

def special_factorial(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
