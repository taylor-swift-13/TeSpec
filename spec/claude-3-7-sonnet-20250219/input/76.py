def _orig_is_simple_power_spec(x: int, n: int, b: bool) -> bool:
    """
    Python implementation of the Coq definition is_simple_power_spec.
    Returns True if b matches the condition specified in the Coq code.
    """
    condition = False
    if x == 1:
        condition = True
    elif n == 0 and x == 0:
        condition = True
    elif n == 1 and x == 1:
        condition = True
    elif n == -1 and (x == 1 or x == -1):
        condition = True
    elif n == 0:
        if x == 1 or x == 0:
            condition = True
    elif n == 1:
        if x == 1:
            condition = True
    elif n == -1:
        if x == 1 or x == -1:
            condition = True
    elif x != 0:
        k = 0
        while True:
            try:
                val = n ** k
            except OverflowError:
                break
            if val == x:
                condition = True
                break
            if abs(val) > abs(x):
                break
            k += 1
    return b == condition

def is_simple_power_spec(x, n, output):
    return bool(_orig_is_simple_power_spec(x, n, output))
