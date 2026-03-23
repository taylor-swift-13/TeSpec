def sum_product_spec(numbers, result_sum, result_product):
    s = 0
    p = 1
    for n in numbers:
        s += n
        p *= n
    return result_sum == s and result_product == p
