def _orig_get_positive_spec(l, output):
    return output == [x for x in l if x > 0]

def get_positive_spec(l, output):
    return bool(_orig_get_positive_spec(l, output))
