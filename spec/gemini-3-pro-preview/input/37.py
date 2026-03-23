def get_evens(l):
    res = []
    for i in range(len(l)):
        if i % 2 == 0:
            res.append(l[i])
    return res

def sort_even_spec(l, res):
    if len(l) != len(res):
        return False
    
    for i in range(len(l)):
        if i % 2 == 1:
            if l[i] != res[i]:
                return False
                
    evens_l = get_evens(l)
    evens_res = get_evens(res)
    
    if sorted(evens_l) != sorted(evens_res):
        return False
        
    if evens_res != sorted(evens_res):
        return False
        
    return True
