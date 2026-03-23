def get_evens(l):
    output = []
    for i in range(len(l)):
        if i % 2 == 0:
            output.append(l[i])
    return output

def _orig_sort_even_spec(l, output):
    if len(l) != len(output):
        return False
    for i in range(len(l)):
        if i % 2 == 1:
            if l[i] != output[i]:
                return False
    evens_l = get_evens(l)
    evens_res = get_evens(output)
    if sorted(evens_l) != sorted(evens_res):
        return False
    if evens_res != sorted(evens_res):
        return False
    return True

def sort_even_spec(l, output):
    return bool(_orig_sort_even_spec(l, output))
