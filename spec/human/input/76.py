def problem_76_pre(x, n):
    return True

def problem_76_spec(x, n, result):
    def is_simple_power(x, n):
        # Check k = 0 case: n^0 = 1
        if x == 1:
            return True
            
        # Check special bases
        if n == 0:
            # 0^k = 0 for k >= 1
            return x == 0
        if n == 1:
            # 1^k = 1 for all k
            return False
        if n == -1:
            # (-1)^k is 1 or -1. Since x != 1 (checked above), must be -1
            return x == -1
            
        # If x is 0, and n is not 0 (checked above), n^k is never 0
        if x == 0:
            return False
            
        # For |n| >= 2, |n^k| grows strictly.
        # We check k = 1, 2, 3...
        p = n
        abs_x = abs(x)
        while abs(p) <= abs_x:
            if p == x:
                return True
            p *= n
            
        return False

    return result == is_simple_power(x, n)
