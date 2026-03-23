def _orig_prod_signs_spec(arr, output):
    if len(arr) == 0:
        return output is None
    sum_magnitudes = 0
    prod_signs = 1
    for x in arr:
        sum_magnitudes += abs(x)
        if x > 0:
            prod_signs *= 1
        elif x < 0:
            prod_signs *= -1
        else:
            prod_signs *= 0
    return output == sum_magnitudes * prod_signs

def prod_signs_spec(arr, output):
    return bool(_orig_prod_signs_spec(arr, output))
