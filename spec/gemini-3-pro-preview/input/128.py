def prod_signs_spec(arr, res):
    if len(arr) == 0:
        return res is None
    
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
            
    return res == (sum_magnitudes * prod_signs)
