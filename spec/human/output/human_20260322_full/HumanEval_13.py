def problem_13_pre(a: int, b: int) -> bool:
    return a != 0 or b != 0

def problem_13_spec(a: int, b: int, output: int) -> bool:
    # Helper to match Coq's Z.modulo behavior where x mod 0 = x
    def coq_mod(x: int, y: int) -> int:
        if y == 0:
            return x
        return x % y

    # Check (output mod a = 0)
    if coq_mod(output, a) != 0:
        return False
        
    # Check (output mod b = 0)
    if coq_mod(output, b) != 0:
        return False
        
    # Check (forall x : Z, (x mod a = 0) -> (x mod b = 0) -> x > 0 -> x <= output)
    # If both a and b are non-zero, there are infinitely many positive common multiples 
    # (e.g., k * abs(a * b) for any k > 0). Thus, x can be arbitrarily large, and 
    # x <= output will eventually be False.
    # If either a == 0 or b == 0, the premise (x mod 0 = 0) implies x = 0, which 
    # contradicts x > 0. Thus, the implication is vacuously true.
    if a != 0 and b != 0:
        return False
        
    return True

def _impl(a: int, b: int) -> int:
    def query_gcd(a: int, b: int) -> int:
        return a if b == 0 else query_gcd(b, a % b)
    return query_gcd(a, b)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_13_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_13_spec(*input, output))

def greatest_common_divisor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
