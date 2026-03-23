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

def sum_product_spec(numbers, res):
    return res == (sum_list(numbers), prod_list(numbers))
