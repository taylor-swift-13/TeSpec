def _orig_unique_spec(l, output):
    is_sorted = all((output[i] <= output[i + 1] for i in range(len(output) - 1)))
    no_dup = len(output) == len(set(output))
    same_elements = set(output) == set(l)
    return is_sorted and no_dup and same_elements

def unique_spec(l, output):
    return bool(_orig_unique_spec(l, output))
