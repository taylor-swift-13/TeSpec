def keys(d):
    return list(d.keys())

def KeyStr(k, s):
    return str(k) == str(s)

def IsLower(s):
    return str(s) == str(s).lower() and any(c.isalpha() for c in str(s))

def IsUpper(s):
    return str(s) == str(s).upper() and any(c.isalpha() for c in str(s))

def _orig_check_dict_case_spec(d, output):
    ks = keys(d)
    if not ks:
        return output == False

    def get_witnesses(k):
        yield str(k)
        s = str(k)
        yield s.lower()
        yield s.upper()
        if hasattr(k, 'witnesses'):
            for w in k.witnesses():
                yield w

    def has_lower(k):
        for s in get_witnesses(k):
            if KeyStr(k, s) and IsLower(s):
                return True
        return False

    def has_upper(k):
        for s in get_witnesses(k):
            if KeyStr(k, s) and IsUpper(s):
                return True
        return False
    all_lower = all((has_lower(k) for k in ks))
    all_upper = all((has_upper(k) for k in ks))
    return output == (all_lower or all_upper)

def check_dict_case_spec(dict, output):
    return bool(_orig_check_dict_case_spec(dict, output))
