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

def is_intersection(l1, l2, result):
    for x in result:
        if not (x in l1 and x in l2):
            return False
    for x in l1:
        if x in l2:
            if x not in result:
                return False
    return True

def common_spec(l1, l2, result):
    return is_intersection(l1, l2, result) and no_duplicates(result) and is_sorted(result)
