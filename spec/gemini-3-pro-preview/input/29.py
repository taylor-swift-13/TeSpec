def filter_by_prefix_spec(strings, pref, result):
    return result == [s for s in strings if s.startswith(pref)]
