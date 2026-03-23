def is_sorted(l):
    return all(l[i] <= l[i+1] for i in range(len(l)-1))

def no_duplicates(l):
    return len(set(l)) == len(l)

def all_elements_from(output, original):
    return set(output) == set(original)

def _orig_unique_spec(l, output):
    return is_sorted(output) and no_duplicates(output) and all_elements_from(output, l)

def unique_spec(l, output):
    return bool(_orig_unique_spec(l, output))
