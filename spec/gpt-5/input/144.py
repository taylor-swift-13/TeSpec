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

def simplify_spec(x, n, res):
    def find_witness(s):
        # First try the exact string parse to handle large numbers efficiently
        try:
            s_strip = s.strip()
            if '/' in s_strip:
                parts = s_strip.split('/')
                if len(parts) == 2:
                    num, den = int(parts[0]), int(parts[1])
                    if parse_frac(s, num, den):
                        return (num, den)
            else:
                num = int(s_strip)
                if parse_frac(s, num, 1):
                    return (num, 1)
        except:
            pass
            
        # Fallback to bounded search to support abstract/mocked parse_frac relations
        for i in range(1, 200):
            for j in range(1, 200):
                if parse_frac(s, i, j):
                    return (i, j)
                    
        return None

    # Find a unique witness for each string to ensure the biconditional uniquely determines res
    x_witness = find_witness(x)
    n_witness = find_witness(n)
    
    if x_witness is not None and n_witness is not None:
        x1, x2 = x_witness
        n1, n2 = n_witness
        if x1 > 0 and x2 > 0 and n1 > 0 and n2 > 0:
            # The Coq spec requires the biconditional to hold for the specific parsed values
            return res == ((x1 * n1) % (x2 * n2) == 0)
            
    return False
