def sum_odd_at_even_pos(lst):
    output = 0
    for i in range(0, len(lst), 2):
        if lst[i] % 2 != 0:
            output += lst[i]
    return output

def _orig_solution_spec(lst, output):
    return output == sum_odd_at_even_pos(lst)

def solution_spec(lst, output):
    return bool(_orig_solution_spec(lst, output))
