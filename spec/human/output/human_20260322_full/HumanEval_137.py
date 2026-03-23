class VInt:
    def __init__(self, z):
        self.z = z
        
    def __eq__(self, other):
        return isinstance(other, VInt) and self.z == other.z

class VFloat:
    def __init__(self, r):
        self.r = r
        
    def __eq__(self, other):
        return isinstance(other, VFloat) and self.r == other.r

class VStr:
    def __init__(self, s):
        self.s = s
        
    def __eq__(self, other):
        return isinstance(other, VStr) and self.s == other.s

def is_digit(c):
    return '0' <= c <= '9'

def digit_val(c):
    return ord(c) - ord('0')

def digits_to_nat(l, acc):
    for c in l:
        if is_digit(c):
            acc = acc * 10 + digit_val(c)
        else:
            return None
    return acc

def is_sep(c):
    return c == '.' or c == ','

def split_on_sep(l):
    pre = []
    suf = []
    found_sep = False
    for c in l:
        if not found_sep:
            if is_sep(c):
                found_sep = True
            else:
                pre.append(c)
        else:
            suf.append(c)
    return (pre, suf)

def pow10(n):
    return 10.0 ** n

def parse_string(s):
    l = list(s)
    if not l:
        return None
    c0 = l[0]
    if c0 == '-':
        neg = True
        rest = l[1:]
    elif c0 == '+':
        neg = False
        rest = l[1:]
    else:
        neg = False
        rest = l
    
    int_chars, frac_chars = split_on_sep(rest)
    if not int_chars:
        return None
    
    int_v = digits_to_nat(int_chars, 0)
    if int_v is None:
        return None
    
    if not frac_chars:
        return (neg, int_v, 0, 0)
    
    frac_v = digits_to_nat(frac_chars, 0)
    if frac_v is None:
        return None
    
    return (neg, int_v, frac_v, len(frac_chars))

def string_to_R(s):
    parsed = parse_string(s)
    if parsed is None:
        return None
    neg, int_v, frac_v, k = parsed
    if k == 0:
        base = float(int_v)
    else:
        base = float(int_v) + float(frac_v) / pow10(k)
    return -base if neg else base

def value_of_impl(v):
    if isinstance(v, VInt):
        return float(v.z)
    elif isinstance(v, VFloat):
        return float(v.r)
    elif isinstance(v, VStr):
        return string_to_R(v.s)
    return None

def Rlt_bool(x, y):
    return x < y

def compare_one_impl(a, b):
    va = value_of_impl(a)
    vb = value_of_impl(b)
    if va is not None and vb is not None:
        if Rlt_bool(va, vb):
            return b
        elif Rlt_bool(vb, va):
            return a
        else:
            return None
    return None

def problem_137_pre(a, b):
    return True

def problem_137_spec(a, b, res):
    return res == compare_one_impl(a, b)

def _impl(a, b):
    num_a = float(str(a).replace(",", "."))
    num_b = float(str(b).replace(",", "."))
    if num_a == num_b:
        return None
    return a if num_a > num_b else b

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_137_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_137_spec(*input, output))

def compare_one(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
