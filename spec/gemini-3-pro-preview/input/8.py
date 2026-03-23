def sum_product_spec(numbers, res):
    s = 0
    p = 1
    for n in numbers:
        s += n
        p *= n
    return res == (s, p)
