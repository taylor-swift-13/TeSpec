def nth(i, l, default):
    if 0 <= i < len(l):
        return l[i]
    return default

def sorted_asc(l):
    for i in range(len(l)):
        for j in range(len(l)):
            if i < j < len(l):
                if not (nth(i, l, 0) <= nth(j, l, 0)):
                    return False
    return True

def sorted_desc(l):
    for i in range(len(l)):
        for j in range(len(l)):
            if i < j < len(l):
                if not (nth(i, l, 0) >= nth(j, l, 0)):
                    return False
    return True

def hd(default, l):
    if len(l) == 0:
        return default
    return l[0]

def last(l, default):
    if len(l) == 0:
        return default
    return l[-1]

def nat_odd(n):
    return (n % 2) != 0

def In(x, l):
    return x in l

def _orig_sort_array_spec(array, output):
    left_disjunct = array == [] and output == []
    right_disjunct = False
    if len(array) > 0:
        sum_val = hd(0, array) + last(array, 0)
        if nat_odd(sum_val) == True:
            parity_sorted_cond = sorted_asc(output)
        else:
            parity_sorted_cond = sorted_desc(output)
        forall_cond = True
        for x in array + output:
            if not In(x, output) == In(x, array):
                forall_cond = False
                break
        right_disjunct = parity_sorted_cond and forall_cond
    return left_disjunct or (len(array) > 0 and right_disjunct)

def sort_array_spec(array, output):
    return bool(_orig_sort_array_spec(array, output))
