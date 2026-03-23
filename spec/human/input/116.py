def count_ones_helper(n, fuel):
    res = 0
    while fuel > 0:
        if n == 0:
            break
        res += n % 2
        n //= 2
        fuel -= 1
    return res

def count_ones(n):
    return count_ones_helper(n, n)

def lt_custom(a, b):
    ones_a = count_ones(a)
    ones_b = count_ones(b)
    return (ones_a < ones_b) or (ones_a == ones_b and a < b)

def lt_custom_bool(a, b):
    ones_a = count_ones(a)
    ones_b = count_ones(b)
    if ones_a < ones_b:
        return True
    elif ones_a == ones_b:
        return a < b
    else:
        return False

def insert_sorted(x, l):
    for i, h in enumerate(l):
        if lt_custom_bool(x, h):
            return l[:i] + [x] + l[i:]
    return l + [x]

def sort_array_impl(input):
    res = []
    for h in reversed(list(input)):
        res = insert_sorted(h, res)
    return res

def _orig_problem_116_pre(input):
    return True

def _orig_problem_116_spec(input, output):
    return list(output) == sort_array_impl(input)

def problem_116_pre(arr):
    return bool(_orig_problem_116_pre(arr))

def problem_116_spec(arr, output):
    return bool(_orig_problem_116_spec(arr, output))
