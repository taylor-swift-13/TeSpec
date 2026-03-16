
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(l) < 2:
        return True

    def comps_ok_non_strict():
        for a, b in zip(l, l[1:]):
            try:
                _ = a <= b
                _ = a >= b
            except Exception:
                return False
        return True

    def comps_ok_strict():
        for a, b in zip(l, l[1:]):
            try:
                _ = a < b
                _ = a > b
            except Exception:
                return False
        return True

    return comps_ok_non_strict() or comps_ok_strict()


def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    l = input[0]
    if not isinstance(output, bool):
        return False
    if len(l) <= 1:
        return output is True

    def is_non_decreasing():
        for a, b in zip(l, l[1:]):
            try:
                if not (a <= b):
                    return False
            except Exception:
                return None
        return True

    def is_non_increasing():
        for a, b in zip(l, l[1:]):
            try:
                if not (a >= b):
                    return False
            except Exception:
                return None
        return True

    def is_strict_increasing():
        for a, b in zip(l, l[1:]):
            try:
                if not (a < b):
                    return False
            except Exception:
                return None
        return True

    def is_strict_decreasing():
        for a, b in zip(l, l[1:]):
            try:
                if not (a > b):
                    return False
            except Exception:
                return None
        return True

    ndi = is_non_decreasing()
    nin = is_non_increasing()
    si = is_strict_increasing()
    sd = is_strict_decreasing()

    if output is True:
        if ndi is True or nin is True:
            return True
        if (ndi is None or nin is None):
            if si is True or sd is True:
                return True
            if si is None and sd is None:
                return True
        return False
    else:
        return True

def _impl(l: list):
    """Return True is list elements are monotonically increasing or decreasing.
    True
    False
    True"""
    inc, dec = True, True
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]: inc = False
        if l[i] < l[i + 1]: dec = False
    return inc or dec

def monotonic(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
