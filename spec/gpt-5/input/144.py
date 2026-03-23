def parse_frac(s, n, d):
    if not isinstance(s, str):
        return False
    try:
        s = s.strip()
        if '/' in s:
            parts = s.split('/')
            if len(parts) == 2:
                return int(parts[0]) == n and int(parts[1]) == d
        else:
            return int(s) == n and d == 1
    except:
        pass
    return False

def _orig_simplify_spec(x, n, output):

    def find_witness(s):
        try:
            s_strip = s.strip()
            if '/' in s_strip:
                parts = s_strip.split('/')
                if len(parts) == 2:
                    (num, den) = (int(parts[0]), int(parts[1]))
                    if parse_frac(s, num, den):
                        return (num, den)
            else:
                num = int(s_strip)
                if parse_frac(s, num, 1):
                    return (num, 1)
        except:
            pass
        for i in range(1, 200):
            for j in range(1, 200):
                if parse_frac(s, i, j):
                    return (i, j)
        return None
    x_witness = find_witness(x)
    n_witness = find_witness(n)
    if x_witness is not None and n_witness is not None:
        (x1, x2) = x_witness
        (n1, n2) = n_witness
        if x1 > 0 and x2 > 0 and (n1 > 0) and (n2 > 0):
            return output == (x1 * n1 % (x2 * n2) == 0)
    return False

def simplify_spec(x, n, output):
    return bool(_orig_simplify_spec(x, n, output))
