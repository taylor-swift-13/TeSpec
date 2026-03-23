def foldl_Z(f, acc, l):
    for x in l:
        acc = f(acc, x)
    return acc

def eval_digits(base, ds):
    return foldl_Z(lambda acc, d: acc * base + d, 0, ds)

def string_of_digits(ds):
    res = []
    for d in ds:
        # Z.to_nat d is 0 if d < 0, else d
        nat_d = d if d >= 0 else 0
        # ascii_of_nat takes n mod 256
        code = (48 + nat_d) % 256
        res.append(chr(code))
    return "".join(res)

def digits_range(base, ds):
    return all(0 <= t < base for t in ds)

def change_base_spec(x, base, ret):
    # 0 <= x /\ 2 <= base /\ base <= 9
    if not (0 <= x):
        return False
    if not (2 <= base <= 9):
        return False
    
    if x == 0:
        # ret = String (ascii_of_nat 48) EmptyString
        return ret == "0"
    else:
        # x <> 0
        # exists d ds, ret = string_of_digits (d :: ds) /\ ...
        
        if not ret:
            return False
            
        # Reconstruct d and ds from ret
        # Since base <= 9, valid digits are 0..8.
        # The mapping d -> char(48+d) is injective for d in 0..8.
        # We parse ret assuming this mapping.
        
        digits = []
        for c in ret:
            digits.append(ord(c) - 48)
            
        if not digits:
            return False
            
        d = digits[0]
        ds = digits[1:]
        
        # Check 1: ret = string_of_digits (d :: ds)
        # Implicitly checked by parsing logic + range checks below.
        
        # Check 2: 1 <= d < base
        if not (1 <= d < base):
            return False
            
        # Check 3: digits_range base ds
        if not digits_range(base, ds):
            return False
            
        # Check 4: eval_digits base (d :: ds) = x
        if eval_digits(base, digits) != x:
            return False
            
        return True
