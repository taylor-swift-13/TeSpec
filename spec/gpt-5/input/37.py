def evens_list(l):
    return l[::2]

def _orig_sort_even_spec(l, l_prime):
    if len(l) != len(l_prime):
        return False
    es = sorted(evens_list(l))
    for i in range(len(l)):
        if i % 2 == 0:
            if l_prime[i] != es[i // 2]:
                return False
        elif l_prime[i] != l[i]:
            return False
    return True

def sort_even_spec(l, output):
    return bool(_orig_sort_even_spec(l, output))
