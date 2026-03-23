def freq(z, l):
    return sum(1 for x in l if x == z)

def search_spec(lst, ans):
    if not all(x > 0 for x in lst):
        return False
    if not lst:
        return False
    
    valid_ns = [n for n in set(lst) if n > 0 and freq(n, lst) >= n]
    
    if valid_ns:
        return ans == max(valid_ns)
    else:
        return ans == -1
