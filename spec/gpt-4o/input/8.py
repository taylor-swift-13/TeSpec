def sum_product_spec(numbers, result):
    sum_val = 0
    product_val = 1
    for n in numbers:
        sum_val += n
        product_val *= n
    return result == (sum_val, product_val)
