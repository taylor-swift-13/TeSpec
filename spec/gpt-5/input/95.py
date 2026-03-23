def keys(d):
    return list(d.keys())

def KeyStr(k, s):
    return str(k) == str(s)

def IsLower(s):
    return isinstance(s, str) and s.islower()

def IsUpper(s):
    return isinstance(s, str) and s.isupper()

def _orig_check_dict_case_spec(d, output):
    ks = keys(d)
    if not ks:
        return output == False

    all_lower = all(IsLower(k) for k in ks)
    all_upper = all(IsUpper(k) for k in ks)
    return output == (all_lower or all_upper)

def check_dict_case_spec(dict, output):
    return bool(_orig_check_dict_case_spec(dict, output))
