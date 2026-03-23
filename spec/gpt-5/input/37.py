def evens_list(l):
    return l[::2]

def sort_even_spec(l, l_prime):
    if len(l) != len(l_prime):
        return False
    
    es = sorted(evens_list(l))
    
    for i in range(len(l)):
        if i % 2 == 0:
            if l_prime[i] != es[i // 2]:
                return False
        else:
            if l_prime[i] != l[i]:
                return False
                
    return True
