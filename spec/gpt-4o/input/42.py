def incr_list_spec(l, result):
    """
    Returns True if result is equal to the list obtained by incrementing 
    each element of l by 1.
    """
    expected = [x + 1 for x in l]
    return result == expected
