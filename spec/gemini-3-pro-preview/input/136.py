def _orig_largest_smallest_integers_spec(lst, output):
    (neg_res, pos_res) = output
    if neg_res is not None:
        if neg_res not in lst:
            return False
        if neg_res >= 0:
            return False
        for x in lst:
            if x < 0 and x > neg_res:
                return False
    else:
        for x in lst:
            if x < 0:
                return False
    if pos_res is not None:
        if pos_res not in lst:
            return False
        if pos_res <= 0:
            return False
        for x in lst:
            if x > 0 and x < pos_res:
                return False
    else:
        for x in lst:
            if x > 0:
                return False
    return True

def largest_smallest_integers_spec(lst, output):
    return bool(_orig_largest_smallest_integers_spec(lst, output))
