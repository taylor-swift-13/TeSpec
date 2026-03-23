def _orig_incr_list_spec(l, output):
    """
    Returns True if output is equal to the list obtained by incrementing 
    each element of l by 1.
    """
    expected = [x + 1 for x in l]
    return output == expected

def incr_list_spec(l, output):
    return bool(_orig_incr_list_spec(l, output))
