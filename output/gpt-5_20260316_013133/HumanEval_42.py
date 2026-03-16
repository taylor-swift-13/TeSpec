
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    for x in l:
        try:
            _ = x + 1
        except Exception:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    n = len(l)
    for i in range(n):
        try:
            expected = l[i] + 1
        except Exception:
            return False
        out = output[i]
        same = False
        try:
            eq = (expected == out)
            if isinstance(eq, bool):
                same = eq
            else:
                try:
                    same = bool(getattr(eq, "all")())
                except Exception:
                    same = False
        except Exception:
            same = False
        if not same:
            try:
                if (expected != expected) and (out != out):
                    same = True
            except Exception:
                pass
        if not same:
            return False
    return True

def _impl(l: list):
    """Return list with elements incremented by 1.
    [2, 3, 4]
    [6, 4, 6, 3, 4, 4, 10, 1, 124]"""
    return [x + 1 for x in l]

def incr_list(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
