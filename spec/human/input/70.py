def remove_one(x, l):
    res = []
    removed = False
    for item in l:
        if item == x and not removed:
            removed = True
        else:
            res.append(item)
    return res

def list_min(l):
    if not l:
        return None
    return min(l)

def list_max(l):
    if not l:
        return None
    return max(l)

def strange_sort_aux(l, fuel, is_min):
    if fuel == 0:
        return []
    if not l:
        return []
    
    v = list_min(l) if is_min else list_max(l)
    if v is None:
        return []
    
    return [v] + strange_sort_aux(remove_one(v, l), fuel - 1, not is_min)

def strange_sort_list(l):
    return strange_sort_aux(l, len(l), True)

def problem_70_pre(l_in):
    return True

def problem_70_spec(l_in, l_out):
    return l_out == strange_sort_list(l_in)
