def is_sorted(l):
    return all(l[i] <= l[i+1] for i in range(len(l) - 1))

def count_occ_Z(l, x):
    return l.count(x)

def is_permutation_of_sublist(output, original):
    return all(output.count(x) <= original.count(x) for x in set(output))

def are_top_k_elements(output, original, k):
    for x in output:
        for y in original:
            if y not in output and output.count(y) == 0:
                if not (x >= y):
                    return False
    return True

def _orig_maximum_spec(arr, k, output):
    if len(output) != k:
        return False
    if not is_sorted(output):
        return False
    if not is_permutation_of_sublist(output, arr):
        return False
    if k > len(arr):
        return False
    for x in output:
        if x not in arr:
            return False
    for dropped in arr:
        if arr.count(dropped) > output.count(dropped):
            for kept in output:
                if not kept >= dropped:
                    return False
    return True

def maximum_spec(arr, k, output):
    return bool(_orig_maximum_spec(arr, k, output))
