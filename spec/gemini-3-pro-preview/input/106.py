def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)

def sum_1_to_n(n):
    if n == 0:
        return 0
    return n + sum_1_to_n(n - 1)

def f_spec(n, result):
    if len(result) != n:
        return False
    for i in range(n):
        logical_index = i + 1
        val = result[i] if i < len(result) else 0
        if logical_index % 2 == 0:
            if val != factorial(logical_index):
                return False
        else:
            if val != sum_1_to_n(logical_index):
                return False
    return True
