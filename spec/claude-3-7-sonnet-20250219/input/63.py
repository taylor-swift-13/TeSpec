def fibfib_spec(n, res):
    if type(n) is not int or type(res) is not int or n < 0 or res < 0:
        return False
    if n == 0:
        return res == 0
    if n == 1:
        return res == 0
    if n == 2:
        return res == 1
    if n >= 3:
        a = 0
        b = 0
        c = 1
        i = 3
        return res == c
    return False
