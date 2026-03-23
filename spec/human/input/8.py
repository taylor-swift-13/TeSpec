def problem_8_pre():
    return True

def problem_8_spec(l, s, p):
    sum_val = sum(l)
    prod_val = 1
    for x in l:
        prod_val *= x
    return s == sum_val and p == prod_val
