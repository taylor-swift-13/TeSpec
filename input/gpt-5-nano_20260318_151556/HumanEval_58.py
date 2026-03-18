
def common(l1: list, l2: list):
    """
    Return sorted unique common elements for two lists.
    [1, 5, 653]
    [2, 3]
    """
    return sorted(list(set(l1).intersection(set(l2))))
