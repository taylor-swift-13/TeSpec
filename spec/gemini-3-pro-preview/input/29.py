def _orig_filter_by_prefix_spec(strings, pref, output):
    return output == [s for s in strings if s.startswith(pref)]

def filter_by_prefix_spec(strings, prefix, output):
    return bool(_orig_filter_by_prefix_spec(strings, prefix, output))
