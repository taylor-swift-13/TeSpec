def char_to_digit(c: str) -> int:
    return ord(c) - ord('0')

def string_to_val(s: str, base: int) -> int:
    if not s:
        return 0
    c = s[0]
    s_prime = s[1:]
    return char_to_digit(c) * (base ** len(s_prime)) + string_to_val(s_prime, base)

def valid_digits(s: str, base: int) -> bool:
    if not s:
        return True
    c = s[0]
    s_prime = s[1:]
    return 0 <= char_to_digit(c) < base and valid_digits(s_prime, base)

def is_canonical(s: str) -> bool:
    if s and s[0] == '0':
        return False
    return True

def change_base_spec(x: int, base: int, ret: str) -> bool:
    if not (2 <= base < 10):
        return True
    if not (x >= 0):
        return True
    
    cond1 = True
    if x == 0:
        cond1 = (ret == "0")
        
    cond2 = True
    if x > 0:
        cond2 = valid_digits(ret, base) and (string_to_val(ret, base) == x) and is_canonical(ret)
        
    return cond1 and cond2

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
