def char_to_digit(c: str) -> int:
    return ord(c) - ord('0')

def list_ascii_to_nat_aux(l: list, acc: int) -> int:
    for c in l:
        acc = acc * 10 + char_to_digit(c)
    return acc

def list_ascii_to_nat(l: list) -> int:
    return list_ascii_to_nat_aux(l, 0)

def Parse_Fraction(s: list, num: int, den: int) -> bool:
    try:
        idx = s.index('/')
        num_s = s[:idx]
        den_s = s[idx+1:]
        return num == list_ascii_to_nat(num_s) and den == list_ascii_to_nat(den_s)
    except ValueError:
        return False

def problem_144_pre(x: str, n: str) -> bool:
    def get_fraction(s: str):
        l = list(s)
        try:
            idx = l.index('/')
            num_s = l[:idx]
            den_s = l[idx+1:]
            return list_ascii_to_nat(num_s), list_ascii_to_nat(den_s)
        except ValueError:
            return None, None

    nx, dx = get_fraction(x)
    ny, dy = get_fraction(n)
    
    if nx is None or ny is None:
        return False
        
    return nx > 0 and dx > 0 and ny > 0 and dy > 0

def problem_144_spec(x: str, n: str, output: bool) -> bool:
    def get_fraction(s: str):
        l = list(s)
        try:
            idx = l.index('/')
            num_s = l[:idx]
            den_s = l[idx+1:]
            return list_ascii_to_nat(num_s), list_ascii_to_nat(den_s)
        except ValueError:
            return None, None

    num_x, den_x = get_fraction(x)
    num_n, den_n = get_fraction(n)
    
    if num_x is None or num_n is None:
        return False
        
    if not (num_x > 0 and den_x > 0 and num_n > 0 and den_n > 0):
        return False
        
    product_num = num_x * num_n
    product_den = den_x * den_n
    
    expected = (product_num % product_den) == 0
    return output == expected

def _impl(x, n):
    x1, x2 = map(int, x.split("/"))
    n1, n2 = map(int, n.split("/"))
    return (x1 * n1) % (x2 * n2) == 0

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_144_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_144_spec(*input, output))

def simplify(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
