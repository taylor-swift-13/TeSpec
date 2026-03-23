def signZ(x):
    if x < 0:
        return -1
    elif x == 0:
        return 0
    else:
        return 1

def sum_abs(l):
    output = 0
    for x in l:
        output += abs(x)
    return output

def prod_sign(l):
    output = 1
    for x in l:
        output *= signZ(x)
    return output

def _orig_prod_signs_spec(arr, output):
    if len(arr) == 0:
        return output is None
    if 0 in arr:
        return output is not None and output == 0
    expected = sum_abs(arr) * prod_sign(arr)
    return output is not None and output == expected

def prod_signs_spec(arr, output):
    return bool(_orig_prod_signs_spec(arr, output))
