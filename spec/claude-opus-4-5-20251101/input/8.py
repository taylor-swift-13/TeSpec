def sum_list(numbers):
    return sum(numbers)

def product_list(numbers):
    p = 1
    for n in numbers:
        p *= n
    return p

def sum_product_spec(numbers, result):
    return result[0] == sum_list(numbers) and result[1] == product_list(numbers)
