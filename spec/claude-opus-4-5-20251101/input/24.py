def _orig_largest_divisor_spec(n, output):

    def check_n_le_1():
        if n <= 1:
            return output == 1
        return True

    def check_n_gt_1():
        if n > 1:
            if not output >= 1:
                return False
            if not output < n:
                return False
            if n % output != 0:
                return False
            for d in range(output + 1, n):
                disjunct1 = n % d != 0
                disjunct2 = d * (n // d) != n // (n // d)
                if not (disjunct1 or disjunct2):
                    return False
            return True
        return True
    return check_n_le_1() and check_n_gt_1()

def largest_divisor_spec(n, output):
    return bool(_orig_largest_divisor_spec(n, output))
