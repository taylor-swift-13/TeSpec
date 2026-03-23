def sum_odd_at_even_pos(lst):
    res = 0
    for i in range(0, len(lst), 2):
        if lst[i] % 2 != 0:
            res += lst[i]
    return res

def solution_spec(lst, res):
    return res == sum_odd_at_even_pos(lst)
