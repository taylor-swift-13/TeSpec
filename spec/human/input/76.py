def _orig_problem_76_pre(x, n):
    return True

def _orig_problem_76_spec(x, n, output):

    def is_simple_power(x, n):
        if x == 1:
            return True
        if n == 0:
            return x == 0
        if n == 1:
            return False
        if n == -1:
            return x == -1
        if x == 0:
            return False
        p = n
        abs_x = abs(x)
        while abs(p) <= abs_x:
            if p == x:
                return True
            p *= n
        return False
    return output == is_simple_power(x, n)

def problem_76_pre(x, n):
    return bool(_orig_problem_76_pre(x, n))

def problem_76_spec(x, n, output):
    return bool(_orig_problem_76_spec(x, n, output))
