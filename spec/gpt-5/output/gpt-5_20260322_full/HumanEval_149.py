def count(x, l):
    return sum(1 for y in l if x == y)

def ascii_lt(a, b):
    return ord(a) < ord(b)

def string_lex_lt(s, t):
    return s < t

def string_lex_le(s, t):
    return s <= t

def even_length(s):
    return len(s) % 2 == 0

def orderR(s, t):
    if len(s) < len(t):
        return True
    elif len(s) == len(t):
        return string_lex_le(s, t)
    return False

def sorted_list_sum_spec(lst, res):
    all_elements = set(lst + res)
    for s in all_elements:
        if even_length(s):
            if count(s, res) != count(s, lst):
                return False
        else:
            if count(s, res) != 0:
                return False
    
    for i in range(len(res) - 1):
        if not orderR(res[i], res[i+1]):
            return False
            
    return True

def _impl(lst):
    from functools import cmp_to_key
    def cmp(s: str, t: str):
        if len(s) != len(t):
            return len(s) - len(t)
        return -1 if s < t else 1
    return sorted(list(filter(lambda s: len(s) % 2 == 0, lst)), key=cmp_to_key(cmp))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sorted_list_sum_spec(*input, output))

def sorted_list_sum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
