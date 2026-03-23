def signZ(x):
    if x < 0:
        return -1
    elif x == 0:
        return 0
    else:
        return 1

def sum_abs(l):
    res = 0
    for x in l:
        res += abs(x)
    return res

def prod_sign(l):
    res = 1
    for x in l:
        res *= signZ(x)
    return res

def prod_signs_spec(arr, res):
    if len(arr) == 0:
        return res is None
    if 0 in arr:
        return res is not None and res == 0
    
    expected = sum_abs(arr) * prod_sign(arr)
    return res is not None and res == expected
