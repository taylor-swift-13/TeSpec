def special_factorial_spec(n: int, result: int) -> bool:
    """
    Translates the Coq specification special_factorial_spec into executable Python.
    
    The Coq specification:
    - If n = 0, result must be 1.
    - If n = 1, result must be 1 (the forall condition is vacuously true).
    - If n >= 2, the condition requires that for all i in [2, n], there exist fac' and ans'
      such that fac' = fac * i, ans' = ans * fac', fac = fac', and ans = ans'.
      Given the initial conditions fac = 1 and ans = 1, this implies 1 = 1 * i for i >= 2,
      which is impossible for natural numbers. Thus, the spec is False for n >= 2.
    """
    if n == 0:
        # match n with | O => result = 1
        return result == 1
    elif n == 1:
        # match n with | S _ => exists (fac ans : nat), fac = 1 /\ ans = 1 /\ 
        # (forall i : nat, 2 <= i <= 1 -> ...) /\ result = ans
        # The forall is vacuously true for n=1.
        # fac=1, ans=1, result=ans implies result=1.
        return result == 1
    else:
        # For n >= 2, the forall i : nat, 2 <= i <= n includes i = 2.
        # The condition requires exists fac', ans' such that:
        # fac' = fac * 2, ans' = ans * fac', fac = fac', ans = ans'.
        # Since fac = 1 and ans = 1, this implies 1 = 2 and 1 = 2, which is False.
        # Therefore, no result satisfies the spec for n >= 2.
        return False

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
