def _orig_below_threshold_spec(l, t, output):
    return output == all((x < t for x in l))

def below_threshold_spec(l, t, output):
    return bool(_orig_below_threshold_spec(l, t, output))
