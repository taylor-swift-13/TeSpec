def _orig_longest_spec(strings, output):
    if not strings:
        return output is None
    if output is None:
        return len(strings) == 0
    s = output
    if s not in strings:
        return False
    max_len = max((len(x) for x in strings))
    if len(s) < max_len:
        return False
    return True

def longest_spec(strings, output):
    return bool(_orig_longest_spec(strings, output))
