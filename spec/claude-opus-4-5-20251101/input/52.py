def below_threshold_spec(l, t, result):
    return result == all(x < t for x in l)
