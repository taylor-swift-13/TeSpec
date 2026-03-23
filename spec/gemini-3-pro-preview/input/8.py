def _orig_sum_product_spec(numbers, output):
    s = 0
    p = 1
    for n in numbers:
        s += n
        p *= n
    return output == (s, p)

def sum_product_spec(numbers, output):
    return bool(_orig_sum_product_spec(numbers, output))
