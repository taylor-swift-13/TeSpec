def _orig_fibfib_spec(n, output):
    if type(n) is not int or type(output) is not int or n < 0 or (output < 0):
        return False
    if n == 0:
        return output == 0
    if n == 1:
        return output == 0
    if n == 2:
        return output == 1
    if n >= 3:
        a = 0
        b = 0
        c = 1
        i = 3
        return output == c
    return False

def fibfib_spec(n, output):
    return bool(_orig_fibfib_spec(n, output))
