def _orig_all_prefixes_spec(s, output):
    if len(output) != len(s):
        return False
    for i in range(len(s)):
        if output[i] != s[:i + 1]:
            return False
    return True

def all_prefixes_spec(string, output):
    return bool(_orig_all_prefixes_spec(string, output))
