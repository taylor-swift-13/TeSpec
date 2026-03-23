def char_to_digit(c):
    val = ord(c) - ord('0')
    return val if val >= 0 else 0

def list_ascii_to_nat_aux(l, acc):
    for c in l:
        acc = acc * 10 + char_to_digit(c)
    return acc

def list_ascii_to_nat(l):
    return list_ascii_to_nat_aux(l, 0)

def Parse_Fraction(s, num, den):
    if isinstance(s, str):
        s = list(s)
    for i in range(len(s)):
        if s[i] == '/':
            num_s = s[:i]
            den_s = s[i+1:]
            if list_ascii_to_nat(num_s) == num and list_ascii_to_nat(den_s) == den:
                return True
    return False

def problem_144_pre(x, n):
    if isinstance(x, str):
        x = list(x)
    if isinstance(n, str):
        n = list(n)
    
    def exists_valid_parse(s):
        for i in range(len(s)):
            if s[i] == '/':
                num_s = s[:i]
                den_s = s[i+1:]
                num = list_ascii_to_nat(num_s)
                den = list_ascii_to_nat(den_s)
                if num > 0 and den > 0:
                    return True
        return False

    return exists_valid_parse(x) and exists_valid_parse(n)

def problem_144_spec(x, n, output):
    if isinstance(x, str):
        x = list(x)
    if isinstance(n, str):
        n = list(n)
    
    for ix in range(len(x)):
        if x[ix] == '/':
            num_x_s = x[:ix]
            den_x_s = x[ix+1:]
            num_x = list_ascii_to_nat(num_x_s)
            den_x = list_ascii_to_nat(den_x_s)
            if num_x > 0 and den_x > 0:
                for in_ in range(len(n)):
                    if n[in_] == '/':
                        num_n_s = n[:in_]
                        den_n_s = n[in_+1:]
                        num_n = list_ascii_to_nat(num_n_s)
                        den_n = list_ascii_to_nat(den_n_s)
                        if num_n > 0 and den_n > 0:
                            product_num = num_x * num_n
                            product_den = den_x * den_n
                            if product_den > 0:
                                is_whole = (product_num % product_den) == 0
                                if output == is_whole:
                                    return True
    return False
