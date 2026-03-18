
def monotonic(l: list):
    """
    Return True is list elements are monotonically increasing or decreasing.
    True
    False
    True
    """
    inc, dec = True, True
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]: inc = False
        if l[i] < l[i + 1]: dec = False
    return inc or dec
