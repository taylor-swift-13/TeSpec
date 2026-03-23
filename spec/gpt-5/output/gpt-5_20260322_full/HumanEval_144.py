def parse_frac(s, a, b):
    try:
        parts = s.split('/')
        if len(parts) == 2:
            return int(parts[0]) == a and int(parts[1]) == b
        return int(s) == a and b == 1
    except:
        return False

def simplify_spec(x, n, res):
    try:
        parts_x = x.split('/')
        if len(parts_x) == 2:
            x1, x2 = int(parts_x[0]), int(parts_x[1])
        else:
            x1, x2 = int(x), 1
            
        parts_n = n.split('/')
        if len(parts_n) == 2:
            n1, n2 = int(parts_n[0]), int(parts_n[1])
        else:
            n1, n2 = int(n), 1
            
        if x1 > 0 and x2 > 0 and n1 > 0 and n2 > 0:
            expected = ((x1 * n1) % (x2 * n2) == 0)
            return res == expected
        return False
    except:
        return False

def _impl(x, n):
    x1, x2 = map(int, x.split("/"))
    n1, n2 = map(int, n.split("/"))
    return (x1 * n1) % (x2 * n2) == 0

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(simplify_spec(*input, output))

def simplify(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
