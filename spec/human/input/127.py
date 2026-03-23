def is_prime(n):
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True

def problem_127_pre(i1, i2):
    s1, e1 = i1
    s2, e2 = i2
    return s1 <= e1 and s2 <= e2

def problem_127_spec(i1, i2, output):
    s1, e1 = i1
    s2, e2 = i2
    
    s_inter = max(s1, s2)
    e_inter = min(e1, e2)
    
    if s_inter <= e_inter:
        length = e_inter - s_inter
        if is_prime(length):
            return output == "YES"
        else:
            return output == "NO"
    else:
        return output == "NO"
