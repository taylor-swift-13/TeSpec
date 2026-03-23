def sum_Z(l):
    """
    Calculates the sum of a list of integers.
    Equivalent to fold_right Z.add 0 l in Coq.
    """
    return sum(l)

def will_it_fly_spec(q, w, res):
    """
    Checks the specification: res is True if and only if q is a palindrome 
    and the sum of its elements is less than or equal to w.
    """
    # q = rev q
    is_palindrome = (q == q[::-1])
    
    # sum_Z q <= w
    sum_val = sum_Z(q)
    sum_ok = (sum_val <= w)
    
    # res = true <-> (is_palindrome /\ sum_ok)
    condition = is_palindrome and sum_ok
    return res == condition
