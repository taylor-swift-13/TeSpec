def _orig_longest_spec(strings, output):
    if not strings:
        return output is None
    max_len = -1
    longest_str = None
    for s in strings:
        if len(s) > max_len:
            max_len = len(s)
            longest_str = s
    return output == longest_str

def longest_spec(strings, output):
    return bool(_orig_longest_spec(strings, output))
