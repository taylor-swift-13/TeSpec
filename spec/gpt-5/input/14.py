def all_prefixes_spec(s, res):
    if len(res) != len(s):
        return False
    for i in range(len(s)):
        if res[i] != s[:i+1]:
            return False
    return True
