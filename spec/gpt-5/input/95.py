def keys(d):
    return list(d.keys())

def KeyStr(k, s):
    return str(k) == str(s)

# def IsLower(s):
#     # Returns True if s contains no uppercase characters.
#     # This matches Coq's likely behavior for strings like "123" or "".
#     return str(s) == str(s).lower()
#
# def IsUpper(s):
#     # Returns True if s contains no lowercase characters.
#     return str(s) == str(s).upper()

def IsLower(s):
    return str(s) == str(s).lower() and any(c.isalpha() for c in str(s))

def IsUpper(s):
    return str(s) == str(s).upper() and any(c.isalpha() for c in str(s))

def check_dict_case_spec(d, res):
    ks = keys(d)
    if not ks:
        return res == False

    def get_witnesses(k):
        # Yield potential strings s that might satisfy KeyStr(k, s).
        # 1. The string representation of k (primary candidate).
        yield str(k)
        # 2. Lower/Upper versions, in case KeyStr is case-insensitive.
        s = str(k)
        yield s.lower()
        yield s.upper()
        # 3. Custom witnesses if the key object supports them.
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

    all_lower = all(has_lower(k) for k in ks)
    all_upper = all(has_upper(k) for k in ks)

    return res == (all_lower or all_upper)
