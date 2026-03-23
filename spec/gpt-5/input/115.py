def sum_list(l):
    return sum(l)

def divceil(n, c):
    if c == 0:
        return 0
    return (n + c - 1) // c

def max_fill_spec(grid, capacity, ans):
    expected = sum(divceil(sum_list(l), capacity) for l in grid)
    return ans == expected
