def is_sorted(l):
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            return False
    return True

def no_duplicates(l):
    seen = []
    for x in l:
        if x in seen:
            return False
        seen.append(x)
    return True

def is_intersection(l1, l2, output):
    for x in output:
        if not (x in l1 and x in l2):
            return False
    for x in l1:
        if x in l2:
            if x not in output:
                return False
    return True

def _orig_common_spec(l1, l2, output):
    return is_intersection(l1, l2, output) and no_duplicates(output) and is_sorted(output)

def common_spec(l1, l2, output):
    return bool(_orig_common_spec(l1, l2, output))
