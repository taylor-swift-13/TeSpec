def _orig_filter_integers_spec(values, output):
    expected = [v for v in values if type(v) is int]
    return expected == output

def filter_integers_spec(values, output):
    return bool(_orig_filter_integers_spec(values, output))
