def _orig_sum_product_spec(numbers, output):
    sum_val = 0
    product_val = 1
    for n in numbers:
        sum_val += n
        product_val *= n
    return output == (sum_val, product_val)

def sum_product_spec(numbers, output):
    return bool(_orig_sum_product_spec(numbers, output))
