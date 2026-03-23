def sum_Z(l):
    """
    Calculates the sum of a list of integers.
    Equivalent to fold_right Z.add 0 l in Coq.
    """
    return sum(l)

def _orig_will_it_fly_spec(q, w, output):
    """
    Checks the specification: output is True if and only if q is a palindrome 
    and the sum of its elements is less than or equal to w.
    """
    is_palindrome = q == q[::-1]
    sum_val = sum_Z(q)
    sum_ok = sum_val <= w
    condition = is_palindrome and sum_ok
    return output == condition

def will_it_fly_spec(q, w, output):
    return bool(_orig_will_it_fly_spec(q, w, output))
