def sum_list(l):
    return sum(l)

def z_div(a, b):
    if b == 0:
        return 0
    if b > 0:
        return a // b
    return (-a - b - 1) // (-b)

def _orig_max_fill_spec(grid, capacity, output):
    expected = 0
    for row in grid:
        val = z_div(sum_list(row) + capacity - 1, capacity)
        expected += val
    return output == expected

def max_fill_spec(grid, capacity, output):
    return bool(_orig_max_fill_spec(grid, capacity, output))
