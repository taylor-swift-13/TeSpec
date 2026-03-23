def sum_list(l):
    """
    Calculates the sum of a list of integers, mimicking Coq's fold_left Z.add l 0.
    """
    res = 0
    for x in l:
        res += x
    return res

def _orig_below_zero_spec(operations, output):
    """
    Checks if the given output (bool) correctly identifies whether any prefix 
    of the operations list has a sum less than zero.
    
    output = True  <-> exists a prefix with sum < 0
    output = False <-> all prefixes have sum >= 0
    """
    has_negative_prefix = False
    for i in range(len(operations) + 1):
        prefix = operations[:i]
        if sum_list(prefix) < 0:
            has_negative_prefix = True
            break
    return output == has_negative_prefix

def below_zero_spec(operations, output):
    return bool(_orig_below_zero_spec(operations, output))
