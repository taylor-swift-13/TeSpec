def sum_list(l):
    acc = 0
    for x in l:
        acc += x
    return acc

def prod_list(l):
    acc = 1
    for x in l:
        acc *= x
    return acc

def _orig_sum_product_spec(numbers, output):
    return output == (sum_list(numbers), prod_list(numbers))

def sum_product_spec(numbers, output):
    return bool(_orig_sum_product_spec(numbers, output))
