def _orig_incr_list_spec(l, output):
    return output == [x + 1 for x in l]

def incr_list_spec(l, output):
    return bool(_orig_incr_list_spec(l, output))
