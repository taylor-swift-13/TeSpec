def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)

def sum_1_to_n(n):
    if n == 0:
        return 0
    return n + sum_1_to_n(n - 1)

def _orig_f_spec(n, output):
    if len(output) != n:
        return False
    for i in range(n):
        logical_index = i + 1
        val = output[i] if i < len(output) else 0
        if logical_index % 2 == 0:
            if val != factorial(logical_index):
                return False
        elif val != sum_1_to_n(logical_index):
            return False
    return True

def f_spec(n, output):
    return bool(_orig_f_spec(n, output))
