def is_sorted(l):
    return all(l[i] <= l[i+1] for i in range(len(l) - 1))

def count_occ_Z(l, x):
    return l.count(x)

def is_permutation_of_sublist(result, original):
    return all(result.count(x) <= original.count(x) for x in set(result))

def are_top_k_elements(result, original, k):
    for x in result:
        for y in original:
            if y not in result and result.count(y) == 0:
                if not (x >= y):
                    return False
    return True

def maximum_spec(arr, k, result):
    if len(result) != k:
        return False
    if not is_sorted(result):
        return False
    if not is_permutation_of_sublist(result, arr):
        return False
    if k > len(arr):
        return False
    for x in result:
        if x not in arr:
            return False
    for dropped in arr:
        if arr.count(dropped) > result.count(dropped):
            for kept in result:
                if not (kept >= dropped):
                    return False
    return True
