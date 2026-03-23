def is_substring(part: str, whole: str) -> bool:
    return part in whole

def is_rotation(s: str, r: str) -> bool:
    return len(s) == len(r) and s in r + r

def cycpattern_check_spec(a: str, b: str, res: bool) -> bool:
    has_rot_substr = False
    if len(b) == 0:
        has_rot_substr = True
    else:
        for i in range(len(b)):
            r = b[i:] + b[:i]
            if is_substring(r, a):
                has_rot_substr = True
                break
                
    return res == has_rot_substr
