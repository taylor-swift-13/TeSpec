def _orig_longest_spec(strings, output):
    if not strings:
        return output is None
    maxlen = max((len(x) for x in strings))
    max_strings = [x for x in strings if len(x) == maxlen]
    if not max_strings:
        return False
    s = max_strings[0]
    for t in max_strings:
        if t != s:
            return False
    return output == s

def longest_spec(strings, output):
    return bool(_orig_longest_spec(strings, output))
