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

def sort_array_spec(array, result):
    left_disjunct = (array == [] and result == [])
    
    right_disjunct = False
    if len(array) > 0:
        sum_val = hd(0, array) + last(array, 0)
        
        if nat_odd(sum_val) == True:
            parity_sorted_cond = sorted_asc(result)
        else:
            parity_sorted_cond = sorted_desc(result)
            
        forall_cond = True
        for x in array + result:
            if not (In(x, result) == In(x, array)):
                forall_cond = False
                break
                
        right_disjunct = parity_sorted_cond and forall_cond

    return left_disjunct or (len(array) > 0 and right_disjunct)
