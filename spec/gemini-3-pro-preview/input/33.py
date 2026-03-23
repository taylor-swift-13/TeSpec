def extract_thirds(l, i):
    res = []
    for j, x in enumerate(l):
        if (i + j) % 3 == 0:
            res.append(x)
    return res

def sort_third_spec(l, res):
    if len(res) != len(l):
        return False
        
    for i in range(len(l)):
        if i % 3 != 0:
            if res[i] != l[i]:
                return False
                
    ext_res = extract_thirds(res, 0)
    ext_l = extract_thirds(l, 0)
    
    if sorted(ext_res) != sorted(ext_l):
        return False
        
    if ext_res != sorted(ext_res):
        return False
        
    return True
