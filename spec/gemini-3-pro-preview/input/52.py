def below_threshold_spec(l, t, res):
    return res == all(x < t for x in l)
