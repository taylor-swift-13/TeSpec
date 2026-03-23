def foldl_Z(f, acc, l):
    res = acc
    for x in l:
        res = f(res, x)
    return res

def eval_digits(base, ds):
    return foldl_Z(lambda acc, d: acc * base + d, 0, ds)

def string_of_digits(ds):
    return "".join(chr(48 + d) for d in ds)

def digits_range(base, ds):
    return all(0 <= t < base for t in ds)

def change_base_spec(x, base, ret):
    if not (0 <= x and 2 <= base <= 9):
        return False
    
    if x == 0:
        return ret == "0"
    
    if not ret:
        return False
        
    digits = [ord(c) - 48 for c in ret]
    d = digits[0]
    ds = digits[1:]
    
    if not (1 <= d < base):
        return False
        
    if not digits_range(base, ds):
        return False
        
    if eval_digits(base, digits) != x:
        return False
        
    return True

def _impl(x: int, base: int):
    if x == 0: return "0"
    ret = ""
    while x != 0:
        ret = str(x % base) + ret
        x //= base
    return ret

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(change_base_spec(*input, output))

def change_base(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
