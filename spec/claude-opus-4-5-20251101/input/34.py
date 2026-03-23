def is_sorted(l):
    return all(l[i] <= l[i+1] for i in range(len(l)-1))

def no_duplicates(l):
    return len(set(l)) == len(l)

def all_elements_from(result, original):
    return set(result) == set(original)

def unique_spec(l, result):
    return is_sorted(result) and no_duplicates(result) and all_elements_from(result, l)
