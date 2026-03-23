def _orig_longest_spec(strings, output):
    if not strings:
        return output is None
    longest = strings[0]
    for s in strings[1:]:
        if len(s) > len(longest):
            longest = s
    return output == longest

def longest_spec(strings, output):
    return bool(_orig_longest_spec(strings, output))
