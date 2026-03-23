def sum_list(numbers):
    return sum(numbers)

def product_list(numbers):
    p = 1
    for n in numbers:
        p *= n
    return p

def _orig_sum_product_spec(numbers, output):
    return output[0] == sum_list(numbers) and output[1] == product_list(numbers)

def sum_product_spec(numbers, output):
    return bool(_orig_sum_product_spec(numbers, output))
